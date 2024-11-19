import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/features/user/entities/user.dart';
import 'package:traveldart/presentation/pages/multi_page.dart';
import 'package:traveldart/presentation/provider/user_provider.dart';

extension MultiPageState on MultiPage {
  List<User> entryUser(WidgetRef ref) => ref.watch(userNotifierProvider);
}
