import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/modules/result/exception.dart';
import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/features/user/entities/user.dart';
import 'package:traveldart/features/user/repository/user.repository.dart';

part 'user.repository.impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final IsarDataSource isar = ref.read(isarProvider);
  return UserRepositoryImpl(isar);
}

class UserRepositoryImpl implements UserRepository {
  final IsarDataSource _isarDataSource;

  UserRepositoryImpl(this._isarDataSource);

  @override
  Future<Result> addUser({required List<User> user}) async {
    final isar = await _isarDataSource.db;
    try {
      await isar.writeTxn(
        () async {
          await isar.users.putAll(user);
        },
      );

      return Result.success(null);
    } catch (e) {
      CLogger.e(e);
      return Result.failure(const DatabaseException());
    }
  }

  @override
  Future<Result<List<User>>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
