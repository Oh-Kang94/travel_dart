import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/features/user/entities/user.dart';

part 'user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  @override
  List<User> build() {
    return [];
  }

  stackUser(String name) {
    // 새로운 User 객체 생성
    final user = User()..name = name;

    // 기존 state 리스트에 새 User 객체를 추가하고 상태 업데이트
    state = [...state, user];
  }

  popUser(int index) {
    List<User> updatedUsers = List.from(state);

    updatedUsers.removeAt(index);

    state = updatedUsers;
  }

  popAll() {
    state = [];
  }
}
