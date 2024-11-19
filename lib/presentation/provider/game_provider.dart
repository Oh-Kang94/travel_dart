import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/features/game/usecase/make_game.usecase.dart';

part 'game_provider.g.dart';

@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  Game? build() {
    return null;
  }

  fetchGame(template) {
    state = ref.read(makeGameUsecaseProvider).call(template);
  }
}
