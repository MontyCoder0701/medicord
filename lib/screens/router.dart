import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'home.screen.dart';
import 'record/record.dart';
import 'stat/stat.dart';

class CustomRouter {
  static RouterConfig<RouteMatchList> getConfig() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      initialLocation: '/record',
      navigatorKey: rootNavigatorKey,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => RecordListProvider()),
            ],
            child: HomeScreen(shell: shell),
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/record',
                  builder: (context, state) => const RecordListScreen(),
                  routes: [
                    GoRoute(
                      path: ':recordId',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (_) => RecordDetailProvider(),
                        child: RecordDetailScreen(
                          recordId:
                              int.parse(state.pathParameters['recordId']!),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/stat',
                  builder: (context, state) => const StatScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
