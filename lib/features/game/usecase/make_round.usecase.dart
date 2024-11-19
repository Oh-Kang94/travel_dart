import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/modules/usecase/base_no_future.usecase.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/features/game/entities/template.dart';

part 'make_round.usecase.g.dart';

@riverpod
MakeRoundUsecase makeGameUsecase(Ref ref) {
  return MakeRoundUsecase();
}

class MakeRoundUsecase extends BaseNoFutureUseCase<Template?, Round> {
  @override
  Round call(Template? param) {
    if (param != null) {
      Round round = param.rounds.first;
      return round;
    }
    return Round();
  }
}
