import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/features/game/repository/round.repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  Future<Game> makeTemplate() {
    // TODO: implement makeTemplate
    throw UnimplementedError();
  }
}
