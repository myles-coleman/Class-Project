import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:classproject/components/drawer.dart';

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: Drawer(child: buildDrawer(context)),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // The user is not signed in
            return Center(
              child: ElevatedButton(
                child: const Text('Go to Login Page'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            );
          } else {
            User user = snapshot.data!;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoURL ?? ''),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome, ${user.displayName ?? 'User'}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
