import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/features/game/usecase/make_round.usecase.dart';

part 'round_provider.g.dart';

@riverpod
class RoundNotifier extends _$RoundNotifier {
  @override
  List<Round?> build() {
    return [];
  }

  fetchRound(template) {
    state = state..add(ref.read(makeGameUsecaseProvider).call(template));
  }
}
