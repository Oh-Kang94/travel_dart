import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/core/util/snack_bar_service.dart';
import 'package:traveldart/presentation/pages/multi_page.dart';
import 'package:traveldart/presentation/provider/user_provider.dart';

extension MultiPageEvent on MultiPage {
  // Stack User
  onAddUser(WidgetRef ref, {required TextEditingController userAddController}) {
    final user = userAddController.text;
    if (user.trim().isEmpty) {
      SnackBarService.showFailedSnackBar(text: "공백으로 이름을 적지 마시오");
      return;
    }
    ref.read(userNotifierProvider.notifier).stackUser(user);
    userAddController.clear();
  }

  // Pop All User
  popAllUser(WidgetRef ref) {
    ref.read(userNotifierProvider.notifier).popAll();
  }

  popUser(WidgetRef ref, {required int index}) {
    ref.read(userNotifierProvider.notifier).popUser(index);
  }
}
