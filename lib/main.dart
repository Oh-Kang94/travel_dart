import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/util/logger.dart';
import 'package:traveldart/presentation/pages/main_page.dart';

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
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainPage(),
        );
      },
    );
  }
}
