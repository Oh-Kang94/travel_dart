import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/router/routes.dart';
import 'package:traveldart/presentation/pages/splash_page.dart';

extension SplashPageEvent on SplashPage {
  Future<void> goMain(WidgetRef ref) async {
    await Future.delayed(
      const Duration(seconds: 1),
      () => const MainRoute().go(ref.context),
    );
  }
}
