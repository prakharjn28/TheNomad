import 'package:TheNomad/models/loginModel.dart';
import 'package:TheNomad/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:TheNomad/provider/loginProvider.dart';
import 'package:provider/provider.dart';

void main() {
  group('Login Screen Widget Tests', () {
    late LoginProvider loginProvider;

    setUp(() {
      loginProvider = LoginProvider();
    });

    testWidgets('Should display email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Login()));
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('Should display login button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Login()));
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Should display forgot password button',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Login()));
      expect(find.text('Forgot Password'), findsOneWidget);
    });

    testWidgets('Should display sign up button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Login()));
      expect(find.text('Sign up'), findsOneWidget);
    });

    testWidgets('Should show validation errors when no inputs are provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: loginProvider),
          ],
          child: const MaterialApp(home: Login()),
        ),
      );

      // tap the login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // verify that signInUser was not called
      verifyNever(loginProvider.signInUser(LoginModel as LoginModel));

      // verify that error messages are displayed for both email and password fields
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });
    testWidgets(
      'Should call loginUser when login button is pressed with valid inputs',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: loginProvider),
            ],
            child: const MaterialApp(home: Login()),
          ),
        );

        // set up text form field inputs
        const emailInput = 'test@test.com';
        const passwordInput = 'password123';
        await tester.enterText(find.byType(TextFormField).at(0), emailInput);
        await tester.enterText(find.byType(TextFormField).at(1), passwordInput);

        // mock the signInUser method
        when(loginProvider.signInUser(
                LoginModel(email: emailInput, password: passwordInput)))
            .thenAnswer((_) => Future.value('Success'));

        // tap the login button
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        // verify that signInUser was called with the correct arguments
        verify(loginProvider.signInUser(
                LoginModel(email: emailInput, password: passwordInput)))
            .called(1);

        // verify that the screen navigated to the search screen
        expect(find.text('Search'), findsOneWidget);
      },
    );

    // testWidgets('Should display error message in alert dialog when login fails',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(const MaterialApp(home: Login()));

    //   // set up text form field inputs
    //   const emailInput = 'test@test.com';
    //   const passwordInput = 'password123';
    //   await tester.enterText(find.byType(TextFormField).at(0), emailInput);
    //   await tester.enterText(find.byType(TextFormField).at(1), passwordInput);

    //   // mock the signInUser method
    //   when(mockLoginProvider.signInUser(
    //           LoginModel(email: emailInput, password: passwordInput)))
    //       .thenAnswer((_) => Future.value('Invalid email or password'));

    //   // tap the login button
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();

    //   // verify that signInUser was called with the correct arguments
    //   verify(mockLoginProvider.signInUser(
    //           LoginModel(email: emailInput, password: passwordInput)))
    //       .called(1);

    //   // verify that an alert dialog with the error message was displayed
    //   expect(find.text('Invalid email or password'), findsOneWidget);
    //   expect(find.text('OK'), findsOneWidget);
    // });
  });
}
