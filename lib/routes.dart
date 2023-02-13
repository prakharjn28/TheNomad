import 'package:TheNomad/screens/details.dart';
import 'package:TheNomad/screens/homesearchview.dart';
import 'package:TheNomad/screens/login_screen.dart';
import 'package:TheNomad/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';
  static const String signup = '/signup';
  static const String search = '/search';
  static const String home = '/home';
  static const String details = '/details';


  static const _title = "Searching Page";
  static const _homeTitle ="Home Page";
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
      GoRoute(
        path: search,
        builder: (context, state) => const MySearchPage(title: _title),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const MyHomePage(title: _homeTitle),
      ),
      GoRoute(
          path: details,
          builder: (context, state) {
            return DetailsPage(title: state.queryParams['states']);
          }
      ),
    ],
  );
}
