import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/router/routes.dart';
import 'package:traveldart/app/theme/app_color.dart';
import 'package:traveldart/app/theme/app_text_style.dart';
import 'package:traveldart/core/constants/padding.dart';
import 'package:traveldart/core/util/app_size.dart';
import 'package:traveldart/presentation/components/common/custom_button.dart';
import 'package:traveldart/presentation/components/common/default_app_bar.dart';
import 'package:traveldart/presentation/components/common/space.dart';
import 'package:traveldart/presentation/pages/base/base_page.dart';
import 'package:traveldart/presentation/pages/multi_page.state.dart';
import 'package:traveldart/presentation/pages/multi_page.event.dart';

class MultiPage extends BasePage {
  const MultiPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final userAddController = useTextEditingController();
    final canSelect = useState(false);

    useEffect(() {
      void listener() {
        canSelect.value = userAddController.text.isNotEmpty;
      }

      userAddController.addListener(listener);
      // cleanup 함수로 리스너 제거
      return () => userAddController.removeListener(listener);
    }, [userAddController]);

    return Padding(
      padding: AppPadding.defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "선수 참가",
            style: AppTextStyle.title1,
          ),
          Row(
            children: [
              Flexible(
                flex: 3,
                child: TextField(
                  controller: userAddController,
                  onEditingComplete: () => onAddUser(
                    ref,
                    userAddController: userAddController,
                  ),
                  decoration: InputDecoration(
                    hintText: '참가자 등장이여~',
                    suffixIcon: IconButton(
                      onPressed: userAddController.clear,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: CustomButton(
                    content: '참가여~',
                    onTap: () => onAddUser(
                      ref,
                      userAddController: userAddController,
                    ),
                    canSelect: userAddController.text.isNotEmpty,
                  ),
                ),
              )
            ],
          ),
          Space.defaultColumn(),
          buildUserList(ref),
        ],
      ),
    );
  }

  Widget buildUserList(WidgetRef ref) {
    final users = entryUser(ref);

    const padding = 20 * 2; // Default Padding is 20

    if (users.isEmpty) return const SizedBox.shrink(); // 유저가 없으면 빈 공간 반환

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "선수들 : ${users.length}명",
              style: AppTextStyle.headline3,
            ),
            IconButton(
              onPressed: () => popAllUser(ref),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.of.black)),
          width: AppSize.to.screenWidth - padding,
          constraints: BoxConstraints(
            maxHeight: AppSize.to.screenWidth,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(users[index].name),
                    IconButton(
                      onPressed: () => popUser(ref, index: index),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
          ),
        ),
        if (users.length >= 2)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: CustomButton(
              content: "다음으로",
              onTap: () => const RoundMakeRoute(gameId: null, roundIds: null)
                  .push(ref.context),
            ),
          )
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return DefaultAppBar(
      ref,
      title: "여러명이서 정하기",
    );
  }
}
