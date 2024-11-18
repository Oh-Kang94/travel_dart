import 'package:isar/isar.dart';
import 'package:traveldart/features/game/entities/round.dart';

part 'template.g.dart';

@collection
class Template {
  Id id = Isar.autoIncrement;
  late String name;
  @Backlink(to: 'template')
  final rounds = IsarLinks<Round>(); // 여러 라운드를 포함하는 링크

  @override
  String toString() {
    return "Template(name :$name, rounds : ${rounds.toString()})";
  }
}
