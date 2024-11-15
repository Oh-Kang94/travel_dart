import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/router/routes.dart';
import 'package:traveldart/presentation/components/common/custom_button.dart';
import 'package:traveldart/presentation/components/common/default_app_bar.dart';
import 'package:traveldart/presentation/components/common/space.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';

class MainPage extends BasePage {
  const MainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            content: '혼자 정하기',
            onTap: () => const SingleRoute().go(ref.context),
          ),
          Space.defaultColumn(),
          CustomButton(
            content: '여러명이서 정하기',
            onTap: () => const MultiRoute().go(ref.context),
          ),
          Space.defaultColumn(),
          CustomButton(
            content: '결과 보기',
            doAnimate: false,
            onTap: () => const ResultRoute().go(ref.context),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return DefaultAppBar(
      ref,
      title: "믿음으로 가는 여행",
      hasLeading: false,
    );
  }
}
