import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:traveldart/presentation/components/common/spin_wheel.dart';
import 'package:traveldart/presentation/pages/main_page.dart';

class WhoSelectPage extends StatefulWidget {
  const WhoSelectPage({
    super.key,
    // required this.resultList,
  });
  // final List<Result> resultList;
  @override
  State<WhoSelectPage> createState() => _WhoSelectPageState();
}

class _WhoSelectPageState extends State<WhoSelectPage> {
  List<String> list = [];
  // List<Result> rawList = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('최종 결정권자 선택')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinWheel(
              items: list,
              onSpinEnd: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_selectedIndex != -1)
              Text(
                '선택된 사람: ${list[_selectedIndex]}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            if (_selectedIndex != -1)
              ElevatedButton(
                onPressed: showDialogResult,
                child: const Text("결과 보기"),
              ),
          ],
        ),
      ),
    );
  }

  _initialize() {
    // rawList = widget.resultList;
    // for (var element in rawList) {
    //   list.add(element.name!);
    // }
    setState(() {});
  }

  void goMain() {
    // SaveResult.cleanResult();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
      (Route<dynamic> route) => false, // 이전 경로를 모두 제거
    );
  }

  showDialogResult() {
    // final Result result = rawList[_selectedIndex];
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "축하합니다.",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //     "최종 여행지는 \n${result.name!}의 \n${result.toString()} \n입니다."),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clipboard.setData(ClipboardData(text: result.toString()))
                    //     .then((result) {
                    //   const snackBar = SnackBar(
                    //     backgroundColor: Colors.white,
                    //     content: Text('복사되었습니다.', style: TextStyle(color: Colors.black),),
                    //   );
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // });
                  },
                  child: const Text("결과 복사하기"),
                ),
                ElevatedButton(
                  onPressed: goMain,
                  child: const Text("처음으로 돌아가기"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
