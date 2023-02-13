import 'package:go_router/go_router.dart';
import 'package:teamwork/details.dart';
import 'package:teamwork/homepageview.dart';

const _title = "Searching Page";

final routes = [
  GoRoute(
    path: '/home',
    builder: (context, state) => const MyHomePage(title: _title),
  ),
  GoRoute(
      path: '/details',
      builder: (context, state) {
        return DetailsPage(title: state.queryParams['states']);
      }
  ),
];