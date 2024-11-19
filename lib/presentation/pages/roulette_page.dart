import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/presentation/components/common/default_app_bar.dart';
import 'package:traveldart/presentation/components/common/spin_wheel.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';
import 'package:traveldart/presentation/provider/round_provider.dart';

class RoulettePage extends BasePage {
  const RoulettePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    var selectedIndex = useState(-1);
    List<String> list = [];
    final Round? round = ref.watch(roundNotifierProvider)[0];
    for (var element in round!.options!) {
      list.add(element.content!);
    }
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinWheel(
          items: list,
          onSpinEnd: (index) {
            selectedIndex.value = index;
          },
        ),
        const SizedBox(height: 20),
        if (selectedIndex.value != -1)
          Text(
            '선택된 동: ${list[selectedIndex.value]}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 20),
      ],
    ));
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(roundNotifierProvider).first!.topic;

    return DefaultAppBar(ref, title: topic);
  }
}
