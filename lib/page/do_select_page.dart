import 'package:flutter/material.dart';
import 'package:traveldart/components/spin_wheel.dart';
import 'package:traveldart/model/result.dart';
import 'package:traveldart/page/gu_select_page.dart';
import 'package:traveldart/services/get_sigudong.dart';

class DoSelectPage extends StatefulWidget {
  const DoSelectPage({super.key});

  @override
  State<DoSelectPage> createState() => _DoSelectPageState();
}

class _DoSelectPageState extends State<DoSelectPage> {
  final GetSigudong getSiGuDong = GetSigudong();
  List<String> list = [];
  List<String> rawList = [];
  int _selectedIndex = -1;
  bool isLoading = true; // 로딩 상태 변수 추가

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
      appBar: AppBar(title: const Text('시 선택')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // 로딩 중일 때 인디케이터 표시
            : Column(
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
                      '선택된 시: ${rawList[_selectedIndex]}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 20),
                  if (_selectedIndex != -1)
                    ElevatedButton(
                      onPressed: goNextPage,
                      child: const Text("구 선택하기"),
                    ),
                ],
              ),
      ),
    );
  }

  _initialize() async {
    rawList = await getSiGuDong.loadUniqueSi();
    for (String item in rawList) {
      list.add(item.substring(0, 2));
    }
    setState(() {
      isLoading = false; // 데이터를 로드한 후 로딩 상태를 false로 변경
    });
  }

  void goNextPage() {
    final Result result =
        Result(name: null, si: rawList[_selectedIndex], gu: null, dong: null);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return GuSelectPage(result: result);
        },
      ),
    );
  }
}
