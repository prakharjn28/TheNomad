import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nomad/screen/login_screen.dart';
import 'package:nomad/screen/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

final _routes = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: "loginScreen",
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      name: "signUpScreen",
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _routes,
    );
  }
}
