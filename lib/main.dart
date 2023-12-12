import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:classproject/firebase_options.dart';
import 'package:classproject/home.dart';
import 'package:classproject/login.dart';
import 'package:classproject/settings.dart';
import 'package:classproject/myrecipes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.grey,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeRoute(),
      '/login': (context) => const LoginRoute(),
      '/myrecipes': (context) => const MyRecipesRoute(),
      '/settings': (context) => const SettingsRoute(),
    },
  ));
}
