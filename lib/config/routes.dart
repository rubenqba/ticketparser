
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketparser/google_ml/google_ml_screen.dart';
import 'package:ticketparser/home/home_screen.dart';

GoRouter initRouter() {
  return GoRouter(
    // redirect: (state) {
    //   final isLoggedIn = sessionInfo.isLoggedIn;
    //   final toLogin = state.location == '/login';

    //   if (!isLoggedIn) return '/login';
    //   if (isLoggedIn && toLogin) return '/home';
    //   return null;
    // },
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: '/google_ml',
    routes: [
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/google_ml',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const GoogleMLScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        )),
  );
}