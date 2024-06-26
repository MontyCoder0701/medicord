import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'repositories/repositories.dart';
import 'screens/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalRepository.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
