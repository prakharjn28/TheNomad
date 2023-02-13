import 'package:TheNomad/screens/login_screen.dart';
import 'package:TheNomad/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';
  static const String signup = '/signup';

  static final routes = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        name: "loginScreen",
        path: login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        name: "signUpScreen",
        path: signup,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
