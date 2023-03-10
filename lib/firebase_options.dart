// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDtvbq1gSeDKppxfklPumZFTp5QP0DyZT0',
    appId: '1:721464880893:web:24b1e87e039fae733a1894',
    messagingSenderId: '721464880893',
    projectId: 'thenomad-2f01b',
    authDomain: 'thenomad-2f01b.firebaseapp.com',
    storageBucket: 'thenomad-2f01b.appspot.com',
    measurementId: 'G-35RKM1H0J5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqSdj_714vmSKOSzhvp31msFlLY25wVI4',
    appId: '1:721464880893:android:ec0b9656f23608093a1894',
    messagingSenderId: '721464880893',
    projectId: 'thenomad-2f01b',
    storageBucket: 'thenomad-2f01b.appspot.com',
  );
}
