import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App'),
      ),
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // The user is signed in
              return const Text('Welcome to the Recipe App!');
            } else {
              // The user is not signed in
              return ElevatedButton(
                child: const Text('Go to Login Page'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              );
            }
          },
        ),
      ),
    );
  }
}
