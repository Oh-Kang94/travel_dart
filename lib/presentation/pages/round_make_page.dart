import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/theme/app_text_style.dart';
import 'package:traveldart/core/constants/padding.dart';
import 'package:traveldart/core/util/app_size.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/presentation/components/common/custom_button.dart';
import 'package:traveldart/presentation/components/common/default_app_bar.dart';
import 'package:traveldart/presentation/components/common/space.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';
import 'package:traveldart/presentation/pages/round_make_page.event.dart';
import 'package:traveldart/presentation/provider/template_provider.dart';

class RoundMakePage extends BasePage with RoundMakeEvent {
  const RoundMakePage(this.gameId, this.roundIds, {super.key});

  final String? gameId;
  final List<int>? roundIds;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final list = ref.watch(templateNotifierProvider);
    return list.when(
      data: (List<Template?> data) {
        if (data.isEmpty) return const Text("템플릿이 없습니다.");
        return Padding(
          padding: AppPadding.defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TemplateSection(data: data),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(content: "템플릿 만들기", onTap: () {}),
                  CustomButton(content: "게임 진행하기", onTap: () {}),
                ],
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
      title: gameId ?? "템플릿 생성 및 선택",
    );
  }
}

class _TemplateSection extends ConsumerWidget with RoundMakeEvent {
  const _TemplateSection({required this.data});
  final List data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          "템플릿 선택하기",
          style: AppTextStyle.headline2,
        ),
        Space.defaultColumn(),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: AppSize.to.screenHeight * 0.5,
          ),
          child: ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              int dataIndex = index - 1;
              if (index == 0) {
                return Text(
                  "이름",
                  style: AppTextStyle.title1,
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data[dataIndex]!.name,
                    style: AppTextStyle.title3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomButton(
                      content: "선택",
                      onTap: () => onTapEachTemplate(ref, index: dataIndex),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
