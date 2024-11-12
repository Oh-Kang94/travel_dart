import 'package:flutter/material.dart';
import 'package:traveldart/app/theme/app_color.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      AppColor(),
    ],
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      AppColor.dark(),
    ],
  );
}
