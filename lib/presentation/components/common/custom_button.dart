import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:traveldart/app/theme/app_text_style.dart';

enum ButtonState {
  able,
  pressed,
  disable,
}

class CustomButton extends HookWidget {
  const CustomButton({
    super.key,
    this.canSelect = true,
    this.doAnimate = true,
    this.textStyle,
    required this.content,
    required this.onTap,
  });
  final VoidCallback onTap;
  final bool canSelect;
  final bool doAnimate;
  final String content;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final buttonState = useState(ButtonState.able);
    return GestureDetector(
      onTap: () async => await _handleOnTap(buttonState, onTap),
      child: Text(
        _content(buttonState.value),
        maxLines: 1,
        style: textStyle ?? AppTextStyle.headline3,
        textAlign: TextAlign.center,
      ),
    );
  }

  String _content(ButtonState buttonState) {
    if (!doAnimate) return content;
    return switch (buttonState) {
      ButtonState.able => content,
      ButtonState.pressed => "믿음??",
      ButtonState.disable => content,
    };
  }

  FutureOr<void> _handleOnTap(
    ValueNotifier<ButtonState> buttonState,
    VoidCallback onTap,
  ) async {
    if (!canSelect) return;

    buttonState.value = ButtonState.pressed;
    await Future.delayed(
        Durations.medium2, () => buttonState.value = ButtonState.able);
    onTap();
  }
}
