import 'package:flutter/material.dart';
import 'package:traveldart/presentation/pages/do_select_page.dart';
import 'package:traveldart/presentation/pages/who_select_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // late final List<Result> resultList;
  @override
  void initState() {
    // resultList = SaveResult.resultList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("믿음으로 가는 여행"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const DoSelectPage();
                  },
                ),
              ),
              child: const Text(
                "믿음??",
                style: TextStyle(fontSize: 50),
              ),
            ),
            // if (resultList.isNotEmpty)
            //   const Text(
            //     "던진사람 리스트",
            //     style: TextStyle(fontSize: 20),
            //   ),
            // if (resultList.isNotEmpty)
            //   ListView(
            //     shrinkWrap: true,
            //     children: List.generate(
            //       resultList.length,
            //       (index) => Text(
            //         resultList[index].name!,
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ),
            // if (resultList.isNotEmpty)
            //   MaterialButton(
            //     onPressed: () => Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return WhoSelectPage(
            //             resultList: resultList,
            //           );
            //         },
            //       ),
            //     ),
            //     child: const Text(
            //       "최종 여행지\n정하기",
            //       style: TextStyle(fontSize: 50),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
