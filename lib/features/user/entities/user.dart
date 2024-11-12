import 'package:isar/isar.dart';
import 'package:traveldart/features/game/entities/game.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  late String name;
  final games = IsarLinks<Game>(); // 유저가 참여한 게임 링크
}
