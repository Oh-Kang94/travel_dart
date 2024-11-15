import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/core/modules/usecase/base.usecase.dart';
import 'package:traveldart/features/user/entities/user.dart';
import 'package:traveldart/features/user/repository/user.repository.dart';
import 'package:traveldart/features/user/repository/user.repository.impl.dart';

part 'register_user.usecase.g.dart';

@riverpod
RegisterUserUseCase registerUserUseCase(Ref ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return RegisterUserUseCase(userRepository);
}

final class RegisterUserUseCase extends BaseUseCase<List<User>, Result> {
  final UserRepository _userRepository;

  RegisterUserUseCase(this._userRepository);

  @override
  FutureOr<Result> call(List<User> request) {
    return _userRepository.addUser(user: request);
  }
}
