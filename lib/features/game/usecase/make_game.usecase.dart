import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/modules/usecase/base_no_future.usecase.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/features/game/entities/template.dart';

part 'make_game.usecase.g.dart';

@riverpod
MakeGameUsecase makeGameUsecase(Ref ref) {
  return MakeGameUsecase();
}

class MakeGameUsecase extends BaseNoFutureUseCase<Template?, Game> {
  @override
  Game call(Template? param) {
    if (param != null) {
      return Game()..name = param.name;
    }
    return Game();
  }
}
