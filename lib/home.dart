import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              //check if on the homepage first
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // The user is not signed in
            return buildDrawer(context);
          } else {
            return const SizedBox
                .shrink(); // An empty widget when the user is signed in
          }
        },
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // The user is not signed in
            return ElevatedButton(
              child: const Text('Go to Login Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            );
          } else {
            return const SizedBox
                .shrink(); // An empty widget when the user is signed in
          }
        },
      ),
    );
  }
}
