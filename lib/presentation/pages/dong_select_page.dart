import 'package:flutter/material.dart';
import 'package:traveldart/presentation/components/common/spin_wheel.dart';
import 'package:traveldart/presentation/pages/main_page.dart';
import 'package:traveldart/services/get_sigudong.dart';

class DongSelectPage extends StatefulWidget {
  const DongSelectPage({
    super.key,
    // required this.result,
  });
  // final Result result;

  @override
  State<DongSelectPage> createState() => _DongSelectPageState();
}

class _DongSelectPageState extends State<DongSelectPage> {
  final GetSigudong getSiGuDong = GetSigudong();
  late TextEditingController _controller;
  List<String> list = [];
  List<String> rawList = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('동 선택')),
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
            // Text(
            //     "현재 까지 : ${widget.result.si} ${widget.result.gu} ${_selectedIndex != -1 ? list[_selectedIndex] : ''}"),
            if (_selectedIndex != -1)
              Text(
                '선택된 동: ${list[_selectedIndex]}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: showDialogResult,
            //   child: const Text("결과 보기"),
            // ),
          ],
        ),
      ),
    );
  }

  _initialize() async {
    // rawList = await getSiGuDong.loadDongByGu(widget.result.gu!);
    // for (String item in rawList) {
    //   list.add(item);
    // }
    setState(() {});
  }

  // void goMain({required Result result, required String name}) {
  //   result = result.copyWith(name: name);
  //   SaveResult.addResult(result);

  //   Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (context) => const MainPage()),
  //     (Route<dynamic> route) => false, // 이전 경로를 모두 제거
  //   );
  // }

  // showDialogResult() {
  //   final Result result = widget.result.copyWith(dong: rawList[_selectedIndex]);
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: Container(
  //           width: MediaQuery.of(context).size.width * 0.8,
  //           height: MediaQuery.of(context).size.height * 0.6,
  //           padding: const EdgeInsets.all(10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Align(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   "축하합니다.",
  //                   style: TextStyle(fontSize: 50),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Text("최종 여행지는 \n${result.toString()} \n 입니다."),
  //               TextField(
  //                 controller: _controller, // TextEditingController 연결
  //                 decoration: const InputDecoration(
  //                   labelText: "던진 사람",
  //                 ),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () => goMain(
  //                   result: result,
  //                   name: _controller.text,
  //                 ),
  //                 child: const Text("처음으로 돌아가기"),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
