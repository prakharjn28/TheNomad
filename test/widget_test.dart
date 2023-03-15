// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:TheNomad/main.dart';
import 'package:TheNomad/provider/destinationProvider.dart';
import 'package:TheNomad/provider/loginProvider.dart';
import 'package:TheNomad/routes.dart';
import 'package:TheNomad/screens/homesearchview.dart';
import 'package:TheNomad/screens/locationDetail.dart';
import 'package:TheNomad/screens/signup_screen.dart';
import 'package:TheNomad/widgets/maps_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    await Firebase.initializeApp();
  });

  group('MyApp widget test', () {
    testWidgets('Test if MyApp widget is built correctly', (tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => DestinationProvider()),
        ],
        child: const MyApp(),
      ));

      final titleFinder = find.text('The Nomad');
      expect(titleFinder, findsOneWidget);

      final routerConfigFinder = find.byType(Routes);
      expect(routerConfigFinder, findsOneWidget);
    });
  });

  testWidgets('Map button opens Google Maps', (tester) async {
    // Create a test LocationDetail widget with locaion London
    final locationDetail = LocationDetail(index: '0');

    // Wrap the widget in a MaterialApp to provide the context
    await tester.pumpWidget(MaterialApp(home: locationDetail));

    // Tap the map button
    await tester.tap(find.byType(MapButton));
    await tester.pumpAndSettle();

    // Expect to find the Google Maps screen on screen
    expect(find.byType(GoogleMap), findsOneWidget);
  });

  testWidgets('Location name is displayed correctly', (tester) async {
    // Create a test LocationDetail widget with London
    final locationDetail = LocationDetail(index: '0');

    // Wrap the widget in a MaterialApp to provide the context
    await tester.pumpWidget(MaterialApp(home: locationDetail));

    // Expect to find the location name on screen
    expect(find.text('London'), findsOneWidget);
  });

  group('MySearchPage', () {
    testWidgets('should display list of places', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DestinationProvider(),
            ),
          ],
          child: const MaterialApp(
            home: MySearchPage(),
          ),
        ),
      );

      expect(find.text('Search Places'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should display no place found message', (WidgetTester tester) async {
      final destinationProvider = DestinationProvider();
      await destinationProvider.getList();
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: destinationProvider,
            ),
          ],
          child: const MaterialApp(
            home: MySearchPage(),
          ),
        ),
      );

      expect(find.text('Search Places'), findsOneWidget);
      expect(find.text('No place found!'), findsOneWidget);
    });
  });


}
