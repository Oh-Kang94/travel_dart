import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/theme/app_color.dart';
import 'package:traveldart/app/theme/app_text_style.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar(
    this.ref, {
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.hasLeading = true,
    this.onBackBtnTapped,
  }) : assert(
          hasLeading || leading == null,
          "Can Not Be hasLeading is false and leading have Widget",
        );

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final WidgetRef ref;
  final bool hasLeading;
  final VoidCallback? onBackBtnTapped;

  static const double appbarHeight = 56;

  factory DefaultAppBar.home(WidgetRef ref) {
    return DefaultAppBar(
      ref,
      title: "NFT Example",
      hasLeading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColor.of.white,
      centerTitle: true,
      automaticallyImplyLeading: true,
      leadingWidth: 56,
      actions: actions,
      title: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text(
          title ?? '',
          style: AppTextStyle.headline1.copyWith(color: AppColor.of.black),
        ),
      ),
      leading: hasLeading
          ? leading ??
              IconButton(
                onPressed: onBackBtnTapped ?? context.pop,
                icon: const Icon(Icons.arrow_back_ios),
              )
          : null,
      toolbarHeight: appbarHeight,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
