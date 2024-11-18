import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/features/game/repository/round.repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/services/get_sigudong.dart';

part 'round.repository.impl.g.dart';

@riverpod
RoundRepository roundRepository(Ref ref) {
  final IsarDataSource isar = ref.read(isarProvider);
  return RoundRepositoryImpl(isar);
}

class RoundRepositoryImpl implements RoundRepository {
  final IsarDataSource _isar;

  RoundRepositoryImpl(this._isar);

  @override
  Future<Game> makeSiGuDong() async {
    // final isar = await _isar.db;
    // // 1. GetSigudong 인스턴스 가져오기
    // GetSigudong siGuDong = GetSigudong();

    // // 2. 시 리스트 로드 및 siRound 생성
    // final siStringList = await siGuDong.loadUniqueSi();
    // final siRounds = <Round>[];

    // for (var si in siStringList) {
    //   // 3. siRound 생성
    //   final siRound = Round()
    //     ..topic = '시 선택'
    //     ..options = siStringList.map((si) => Option().fromString(si)).toList();

    //   // 4. 각 시에 대해 gu 리스트 로드 및 guRound 생성
    //   final guStringList = await siGuDong.loadGuBySi(si);
    //   final guRounds = <Round>[];

    //   for (var gu in guStringList) {
    //     // 5. guRound 생성
    //     final guRound = Round()
    //       ..topic = '$si에서 구 선택'
    //       ..options = guStringList.map((gu) => Option().fromString(gu)).toList()
    //       ..previousRound.value = siRound; // guRound는 siRound와 연결

    //     guRounds.add(guRound);

    //     // 6. 각 구에 대해 dong 리스트 로드 및 dongRound 생성
    //     final dongStringList = await siGuDong.loadDongByGu(gu);
    //     final dongRounds = dongStringList.map((dong) {
    //       return Round()
    //         ..topic = '$si $gu에서 동 선택'
    //         ..options =
    //             dongStringList.map((dong) => Option().fromString(dong)).toList()
    //         ..previousRound.value = guRound; // dongRound는 guRound와 연결
    //     }).toList();

    //     // 7. guRound에 dongRounds 연결
    //     guRound.rounds.addAll(dongRounds);
    //   }

    //   // 8. siRound에 guRounds 연결
    //   siRound.rounds.addAll(guRounds);

    //   // 9. 최종적으로 siRounds에 추가
    //   siRounds.add(siRound);
    // }

    // // 10. Game 생성 및 siRounds 연결
    // final game = Game()..name = '시구동 정하기';

    // // 11. Isar 트랜잭션을 사용하여 Game과 관련된 Round 객체 저장
    // await isar.writeTxn(() async {
    //   // 12. Game을 Isar에 저장
    //   final gameId = await isar.games.put(game);

    //   // 13. siRounds를 Isar에 저장하고 Game에 연결
    //   for (var siRound in siRounds) {
    //     final siRoundId = await isar.rounds.put(siRound);
    //     final round = await isar.rounds.get(siRoundId);

    //     // round가 null이 아니면 game.rounds에 추가
    //     if (round != null) {
    //       game.rounds.add(round);
    //     }
    //   }

    //   // 14. 저장된 game을 반환
    //   CLogger.i(game.toString());
    // });

    // return game;
    throw UnimplementedError();
  }

  @override
  Future<Game> makeTemplate() {
    // TODO: implement makeTemplate
    throw UnimplementedError();
  }
}
