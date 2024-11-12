import 'package:isar/isar.dart';
import 'package:traveldart/features/game/entities/round.dart';
import 'package:traveldart/features/user/entities/user.dart';

part 'game.g.dart';

@collection
class Game {
  Id id = Isar.autoIncrement;
  late String name;
  final rounds = IsarLinks<Round>(); // 여러 라운드를 포함하는 링크
  final users = IsarLinks<User>(); // 게임에 참여한 유저들 링크
}
 