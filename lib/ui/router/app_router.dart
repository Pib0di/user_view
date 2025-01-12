import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_view/core/model/user_data.dart';
import 'package:user_view/ui/pages/home/home_page.dart';
import 'package:user_view/ui/pages/user/user_page.dart';

export '../router/router_extensions.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root_page');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomePage.routeName,
  routes: [
    GoRoute(
      name: '$HomePage',
      path: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: '$UserPage',
      path: UserPage.routeName,
      builder: (context, state) {
        if (state.extra is UserData) {
          return UserPage(userData: state.extra as UserData);
        }
        return UserPage(userData: null);
      },
    ),
  ],
  // errorBuilder: (context, state) {},
  redirect: (context, state) {
    return null;
  },
);
