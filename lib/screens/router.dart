import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.screen.dart';
import 'record/record.dart';
import 'stat/stat.dart';

class CustomRouter {
  static RouterConfig<RouteMatchList> getConfig() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      initialLocation: '/record',
      navigatorKey: rootNavigatorKey,
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => HomeScreen(child: child),
          routes: [
            GoRoute(
              path: '/record',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => const RecordListScreen(),
            ),
            GoRoute(
              path: '/stat',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => const StatScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
