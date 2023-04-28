import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/view/login_screen.dart';
import '../features/auth/presentation/view/signup_screen.dart';
import '../features/feed/presentation/view/discover_screen.dart';
import '../features/feed/presentation/view/feed_screen.dart';

class AppRouter {
  //  TODO: add the auth bloc as an input;
  AppRouter();
  final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'feed',
        path: '/feed',
        builder: (BuildContext context, GoRouterState state) {
          //  TODO: Change to feed screen.
          return const FeedScreen();
        },
      ),
      GoRoute(
        name: 'discover',
        path: '/discover',
        builder: (BuildContext context, GoRouterState state) {
          return const DiscoverScreen();
        },
        routes: [
          GoRoute(
            name: 'user',
            path: ':userId',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
          )
        ],
      ),
      GoRoute(
        name: 'login',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            name: 'signup',
            path: 'signup',
            builder: (BuildContext context, GoRouterState state) {
              return const SignupScreen();
            },
          )
        ],
      ),
    ],

    //  TODO: Redirect users to the login screen if they're not authenticated.
  );
}
