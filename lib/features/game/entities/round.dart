import 'package:isar/isar.dart';
import 'package:traveldart/features/game/entities/game.dart';
import 'package:traveldart/features/game/entities/template.dart';

part 'round.g.dart';

@collection
class Round {
  Id id = Isar.autoIncrement;
  late String topic; // 주제
  List<Option>? options; // 라운드 안의 여러 선택지
  Option? selectedOption; // 선택된 선택지
  final game = IsarLink<Game>();
  final template = IsarLink<Template>();
  final previousRound = IsarLinks<Round>(); // 이전 라운드를 가리키는 링크
  final rounds = IsarLinks<Round>(); // 여러 라운드를 연결할 수 있는 IsarLinks 추가

  @override
  String toString() {
    return "Round(topic: $topic options: ${options.toString()}, previousRound : $previousRound)";
  }
}

@embedded
class Option {
  String? content; // 선택지 내용

  Option fromString(String content) {
    return Option()..content = content;
  }

  @override
  String toString() {
    return content ?? '';
  }
}
