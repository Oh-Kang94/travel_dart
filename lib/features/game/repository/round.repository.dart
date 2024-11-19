import 'package:traveldart/features/game/entities/game.dart';

abstract class RoundRepository {
  Future<Game> makeTemplate();
}
