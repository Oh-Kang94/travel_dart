import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/theme/app_text_style.dart';
import 'package:traveldart/core/constants/padding.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/presentation/components/common/default_app_bar.dart';
import 'package:traveldart/presentation/components/common/space.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';
import 'package:traveldart/presentation/provider/template_provider.dart';

class RoundMakePage extends BasePage {
  const RoundMakePage(this.gameId, this.roundIds, {super.key});

  final String? gameId;
  final List<int>? roundIds;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final list = ref.watch(templateProviderProvider);
    return list.when(
      data: (List<Game> gameList) {
        return Padding(
          padding: AppPadding.defaultPadding,
          child: Column(
            children: [
              Text(
                "템플릿 선택하기",
                style: AppTextStyle.headline2,
              ),
              Space.defaultColumn(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: gameList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text("이름");
                  }
                  return GestureDetector(
                    onTap: () {},
                    child: Text(gameList[index - 1].name),
                  );
                },
              )
            ],
          ),
        );
      },
      error: (err, stack) => ErrorWidget(err),
      loading: () => const CircularProgressIndicator(),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return DefaultAppBar(
      ref,
      title: gameId ?? "미정인 Game",
    );
  }
}

// class TemplateWidget extends StatelessWidget {
//   const TemplateWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder();
//   }
// }
