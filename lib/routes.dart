import 'package:TheNomad/main.dart';
import 'package:go_router/go_router.dart';
import 'package:TheNomad/screens/homesearchview.dart';
import 'package:TheNomad/screens/details.dart';


const _title = "Searching Page";
const _homeTitle ="Home Page";

final routes = [
  GoRoute(
    path: '/search',
    builder: (context, state) => const MySearchPage(title: _title),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const MyHomePage(title: _homeTitle),
  ),
  GoRoute(
      path: '/details',
      builder: (context, state) {
        return DetailsPage(title: state.queryParams['states']);
      }
  ),
];