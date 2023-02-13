import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teamwork/routes.dart';

void main() {
  runApp(const MyApp());
}


final _router = GoRouter(
    initialLocation: '/home',
    routes: routes
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Searching Page'),
      routerConfig: _router,
    );
  }
}

