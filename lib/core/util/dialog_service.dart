import 'package:flutter/material.dart';

class DialogService {
  DialogService._();

  static void show(
    BuildContext context, {
    required Dialog dialog,
  }) {
    showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }

  static Future<void> asyncShow(
    BuildContext context, {
    required Dialog dialog,
  }) {
    return Future.value(
      showDialog(
        context: context,
        builder: (_) => dialog,
      ),
    );
  }
}
