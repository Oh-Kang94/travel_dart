import 'package:traveldart/features/sigudong/entities/result.dart';

class SaveResult {
  static List<Result> resultList = [];

  static List<Result> addResult(Result result) {
    resultList.add(result);
    return resultList;
  }

  static List<Result> cleanResult() {
    resultList = [];
    return resultList;
  }
}
