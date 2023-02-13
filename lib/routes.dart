import 'package:go_router/go_router.dart';
import 'screens/homepageview.dart';
import 'screens/details.dart';


const _title = "Searching Page";

final routes = [
  GoRoute(
    path: '/home',
    builder: (context, state) => const MySearchPage(title: _title),
  ),
  GoRoute(
      path: '/details',
      builder: (context, state) {
        return DetailsPage(title: state.queryParams['states']);
      }
  ),
];