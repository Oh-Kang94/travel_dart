import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/app/router/router.dart';
import 'package:traveldart/app/theme/app_color.dart';
import 'package:traveldart/app/theme/app_theme.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/util/app_size.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/presentation/pages/base/responsive_layout.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // landscape 막기
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await IsarDataSource().initialize();

  runApp(
    ProviderScope(
      observers: [
        RiverPodLogger(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final router = ref.watch(routerProvider);
        return MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          themeMode: ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          debugShowCheckedModeBanner: false,
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('ko', ''), // Korean, no country code
          // ],
          builder: (context, child) {
            // App Color from Theme
            AppColor.init(context);
            // App Size
            AppSize.to.init(context);
            return ResponsiveLayoutBuilder(context, child);
          },
        );
      },
    );
  }
}
