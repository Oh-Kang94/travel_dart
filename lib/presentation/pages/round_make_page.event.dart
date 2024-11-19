import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/router/routes.dart';
import 'package:traveldart/core/util/snack_bar_service.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/presentation/provider/game_provider.dart';
import 'package:traveldart/presentation/provider/round_provider.dart';
import 'package:traveldart/presentation/provider/template_provider.dart';

mixin class RoundMakeEvent {
  onTapEachTemplate(WidgetRef ref, {required int index}) {
    final Template? template =
        ref.read(templateNotifierProvider.notifier).getTemplate(index);
    if (template == null) {
      SnackBarService.showFailedSnackBar(text: "템플릿을 가져오는데 실패하였습니다.");
      return;
    }
    // #1 Template 으로 부터 Game 및 Round 복사
    ref.watch(roundNotifierProvider.notifier).fetchRound(template);
    // #2 Template으로 부터 Round 만들기
    ref.watch(gameNotifierProvider.notifier).fetchGame(template);
    // #2 페이지 이동
    const RouletteRoute().go(ref.context);
  }
}
