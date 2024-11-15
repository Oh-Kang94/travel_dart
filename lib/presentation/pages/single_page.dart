import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/core/util/dialog_service.dart';
import 'package:traveldart/presentation/components/common/custom_dialog.dart';
import 'package:traveldart/presentation/components/common/default_app_bar.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';

class SinglePage extends BasePage {
  const SinglePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const Center();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return DefaultAppBar(
      ref,
      // onBackBtnTapped: () async => await _willPop(ref),
    );
  }

  @override
  bool get canPop => false;

  @override
  onWillPop(WidgetRef ref) async {
    // await _willPop(ref);
  }

  // TODO : Need TO FIX For Show Dialog Twice
  Future<void> _willPop(WidgetRef ref) async {
    await Future.delayed(
      Durations.short1,
      () {
        DialogService.asyncShow(
          ref.context,
          dialog: CustomDialog.warning(
            ref.context,
            leftOnPressed: () {
              ref.context.pop();
            },
            rightOnPressed: () {
              ref.context.pop();
              ref.context.pop();
            },
          ),
        );
      },
    );
  }
}
