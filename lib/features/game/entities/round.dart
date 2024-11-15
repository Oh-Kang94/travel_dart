import 'package:isar/isar.dart';
import 'package:traveldart/features/game/entities/game.dart';

part 'round.g.dart';

@collection
class Round {
  Id id = Isar.autoIncrement;
  late String topic; // 주제
  List<Option>? options; // 라운드 안의 여러 선택지
  List<Option>? selectedOption; // 선택된 선택지
  final game = IsarLink<Game>();
  final previousRound = IsarLink<Round>(); // 이전 라운드를 가리키는 링크
}

@embedded
class Option {
  String? content; // 선택지 내용
}
