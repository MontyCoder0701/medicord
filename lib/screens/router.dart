import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.screen.dart';

class CustomRouter {
  static RouterConfig<RouteMatchList> getConfig({
    String initialLocation = '/',
  }) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }
}
