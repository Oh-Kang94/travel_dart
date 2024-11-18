import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_sigudong.g.dart';

@riverpod
GetSigudong siGuDong(Ref ref) {
  return GetSigudong();
}

class GetSigudong {
  Future<List<String>> loadUniqueSi() async {
    final jsonData = await _getJson();

    final uniqueSiSet = <String>{};
    for (var item in jsonData) {
      uniqueSiSet.add(item['si']);
    }

    // Set을 List로 변환하여 반환
    return uniqueSiSet.toList();
  }

  Future<List<String>> loadGuBySi(String si) async {
    final jsonData = await _getJson();
    final guSet = <String>{};
    for (var item in jsonData) {
      if (item['si'] == si) {
        guSet.add(item['gu']);
      }
    }

    // Set을 List로 변환하여 반환
    return guSet.toList();
  }

  Future<List<String>> loadDongByGu(String si) async {
    final jsonData = await _getJson();
    final guSet = <String>{};
    for (var item in jsonData) {
      if (item['gu'] == si) {
        guSet.add(item['dong']);
      }
    }

    // Set을 List로 변환하여 반환
    return guSet.toList();
  }

  _getJson() async {
    // assets 폴더의 JSON 파일을 읽어오기
    final String jsonString =
        await rootBundle.loadString('assets/sigudong.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  }
}
