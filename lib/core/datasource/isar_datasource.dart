import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/features/game/repository/round.repository.dart';
import 'package:traveldart/features/game/repository/round.repository.impl.dart';
import 'package:traveldart/features/user/entities/user.dart';
import 'package:traveldart/services/get_sigudong.dart';

part 'isar_datasource.g.dart';

@riverpod
IsarDataSource isar(Ref ref) {
  return IsarDataSource();
}

/// ### `Singleton Class`
class IsarDataSource {
  // 싱글톤 패턴을 사용하여 인스턴스를 하나만 생성하는 생성자
  IsarDataSource._internal();

  // IsarDataSource의 유일한 인스턴스를 생성 (싱글톤 인스턴스)
  static final IsarDataSource _instance = IsarDataSource._internal();

  // 외부에서 IsarDataSource를 호출할 때마다 동일한 인스턴스를 반환하는 factory 생성자
  factory IsarDataSource() {
    return _instance;
  }

  // Isar 데이터베이스 인스턴스를 비동기로 관리하기 위한 변수 (초기에는 null)
  Future<Isar>? _db;

  // 데이터베이스 인스턴스가 없으면 초기화하고 반환, 있으면 기존 인스턴스를 반환
  Future<Isar> get db async {
    _db ??= _initDb(); // _db가 null이면 _initDb()로 초기화
    return await _db!; // 초기화된 데이터베이스 인스턴스를 반환
  }

  // 데이터베이스를 초기화하는 함수
  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory(); // 앱의 로컬 디렉터리 경로를 가져옴

    // 경로가 존재하지 않으1면 생성
    final dbDirectory = dir;
    if (!dbDirectory.existsSync()) {
      dbDirectory.createSync(recursive: true);
    }
    final isar = await Isar.open(
      // Isar 데이터베이스를 스키마와 함께 오픈
      [
        GameSchema,
        RoundSchema,
        UserSchema,
        TemplateSchema,
      ],
      directory: dir.path,
    );

    await _initializeTemplateAndRounds(isar); // 초기 설정 값이 없으면 기본 값으로 세팅

    return isar; // 초기화된 Isar 인스턴스를 반환
  }

  // 외부에서 호출 가능한 데이터베이스 초기화 함수 (db를 사용하도록 보장)
  Future<void> initialize() async {
    await db; // db getter를 호출하여 데이터베이스를 초기화
  }

  /// CallbackSetting을 초기화하는 함수
  ///
  /// 첫 앱 시동이면 Template을 넣기 위해서,
  Future<void> _initializeTemplateAndRounds(Isar isar) async {
    final templates = await isar.templates.where().findAll();
    if (templates.isEmpty) {
      final siGuDong = GetSigudong();

      // 1. Template 생성
      final template = Template()..name = '시군구 정하기';
      await isar.writeTxn(() async {
        await isar.templates.put(template);
      });

      // 2. 시 라운드 생성
      final siList = await siGuDong.loadUniqueSi();
      final siRound = Round()
        ..topic = '시 정하기'
        ..options = siList.map((si) => Option()..content = si).toList();

      await isar.writeTxn(() async {
        await isar.rounds.put(siRound);
        siRound.template.value = template;
        template.rounds.add(siRound);
        await siRound.template.save();
        await template.rounds.save();
      });

      // 3. 각 시별로 구 라운드 생성 및 연결
      Map<String, Round> guRounds = {}; // 구 라운드를 저장할 맵
      for (String si in siList) {
        final guList = await siGuDong.loadGuBySi(si);
        final guRound = Round()
          ..topic = '구 정하기 ($si)'
          ..options = guList.map((gu) => Option()..content = gu).toList();

        guRounds[si] = guRound; // 나중에 동 라운드와 연결하기 위해 저장

        await isar.writeTxn(() async {
          await isar.rounds.put(guRound);
          guRound.template.value = template;
          guRound.previousRound.add(siRound);
          template.rounds.add(guRound);

          // 시 라운드에서 이 구 라운드로 갈 수 있음을 표시
          siRound.rounds.add(guRound);

          await guRound.template.save();
          await guRound.previousRound.save();
          await template.rounds.save();
          await siRound.rounds.save();
        });
      }

      // 4. 각 구별로 동 라운드 생성 및 연결
      for (String si in siList) {
        final guList = await siGuDong.loadGuBySi(si);
        final guRound = guRounds[si]!;

        for (String gu in guList) {
          final dongList = await siGuDong.loadDongByGu(gu);
          final dongRound = Round()
            ..topic = '동 정하기 ($si $gu)'
            ..options =
                dongList.map((dong) => Option()..content = dong).toList();

          await isar.writeTxn(() async {
            await isar.rounds.put(dongRound);
            dongRound.template.value = template;
            dongRound.previousRound.add(guRound);
            template.rounds.add(dongRound);

            // 구 라운드에서 이 동 라운드로 갈 수 있음을 표시
            guRound.rounds.add(dongRound);

            await dongRound.template.save();
            await dongRound.previousRound.save();
            await template.rounds.save();
            await guRound.rounds.save();
          });
        }
      }
    }
  }
}
