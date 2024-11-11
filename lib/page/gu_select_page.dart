import 'package:flutter/material.dart';
import 'package:traveldart/components/spin_wheel.dart';
import 'package:traveldart/model/result.dart';
import 'package:traveldart/page/dong_select_page.dart';
import 'package:traveldart/services/get_sigudong.dart';

class GuSelectPage extends StatefulWidget {
  const GuSelectPage({super.key, required this.result});
  final Result result;

  @override
  State<GuSelectPage> createState() => _GuSelectPageState();
}

class _GuSelectPageState extends State<GuSelectPage> {
  final GetSigudong getSiGuDong = GetSigudong();
  List<String> list = [];
  List<String> rawList = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('구 선택')),
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
            Text(
                "현재 까지 : ${widget.result.si} ${_selectedIndex != -1 ? list[_selectedIndex] : ''}"),
            if (_selectedIndex != -1)
              Text(
                '선택된 구: ${list[_selectedIndex]}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            if (_selectedIndex != -1)
              ElevatedButton(
                onPressed: goNextPage,
                child: const Text("동 선택하기"),
              ),
          ],
        ),
      ),
    );
  }

  _initialize() async {
    rawList = await getSiGuDong.loadGuBySi(widget.result.si!);
    for (String item in rawList) {
      list.add(item);
    }
    setState(() {});
  }

  void goNextPage() {
    final Result result = widget.result.copyWith(gu: rawList[_selectedIndex]);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DongSelectPage(result: result);
        },
      ),
    );
  }
}
