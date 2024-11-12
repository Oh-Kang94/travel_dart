import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/core/constants/assets.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';
import 'package:traveldart/presentation/pages/splash_page.event.dart';

class SplashPage extends BasePage {
  const SplashPage({super.key});

  final double velocity = 15;
  final Duration animationDuration = const Duration(seconds: 3);

  @override
  void onInit(WidgetRef ref) {
    goMain(ref);
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: animationDuration,
    )..repeat();

    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.value * velocity * pi,
            child: child,
          );
        },
        child: Image.asset(Assets.shinIl),
      ),
    );
  }
}
