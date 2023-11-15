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
    apiKey: 'AIzaSyA_0aMSBhJ_UbZhH_r8rE9PC0OcFhqtl8k',
    appId: '1:786104459709:web:4eb19ecf8e6274997332d4',
    messagingSenderId: '786104459709',
    projectId: 'class-project-f579e',
    authDomain: 'class-project-f579e.firebaseapp.com',
    storageBucket: 'class-project-f579e.appspot.com',
    measurementId: 'G-F3PEBTM7WY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZnubAFZgrQsSvKEGs5lmgLuRbiNugnkc',
    appId: '1:786104459709:android:e76610f4c80f8f187332d4',
    messagingSenderId: '786104459709',
    projectId: 'class-project-f579e',
    storageBucket: 'class-project-f579e.appspot.com',
  );
}
