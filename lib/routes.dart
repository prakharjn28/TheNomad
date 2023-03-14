import 'package:TheNomad/screens/details.dart';
import 'package:TheNomad/screens/homesearchview.dart';
import 'package:TheNomad/screens/locationDetail.dart';
import 'package:TheNomad/screens/login_screen.dart';
import 'package:TheNomad/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

bool status = false;

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        status = false;
        print('User is currently signed out!');
      } else {
        status = true;
        print('User is signed in!');
      }
    });
  }

  static const String login = '/login';
  static const String signup = '/signup';
  static const String search = '/search';
  static const String home = '/home';
  static const String details = '/details';
  static const String locationDetails = '/locationDetails';

  static final routes = GoRouter(
    initialLocation: status ? search : login,
    routes: [
      GoRoute(
        name: login,
        path: login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        name: signup,
        path: signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: search,
        builder: (context, state) => const MySearchPage(),
      ),
      GoRoute(
        path: locationDetails,
        builder: (context, state) => LocationDetail(
          index: state.queryParams['states'],
        ),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const MyApp(),
      ),
      GoRoute(
          name: "details",
          path: details,
          builder: (context, state) {
            return DetailsPage(title: state.queryParams['states']);
          }),
    ],
  );
}
