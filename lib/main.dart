import 'package:flutter/material.dart';

import 'repositories/local.dart';
import 'screens/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalRepository.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    late final theme = Theme.of(context);

    return MaterialApp.router(
      routerConfig: CustomRouter.getConfig(),
      title: 'MediCord',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(color: theme.colorScheme.inversePrimary),
      ),
    );
  }
}
