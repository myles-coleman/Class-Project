import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:classproject/firebase_options.dart';
import 'package:classproject/home.dart';
import 'package:classproject/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    title: 'Recipe App',
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeRoute(),
      '/login': (context) => const LoginRoute(),
    },
  ));
}
