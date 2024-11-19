import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/features/user/entities/user.dart';

abstract class UserRepository {
  Future<Result> addUser({required List<User> user});

  Future<Result<List<User>>> getUser();
}
