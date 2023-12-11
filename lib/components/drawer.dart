import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ListTile(
          title: const Text('Home'),
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != '/') {
              Navigator.pushReplacementNamed(context, '/');
            } else {
              Navigator.pop(context);
            }
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != '/settings') {
              Navigator.pushReplacementNamed(context, '/settings');
            } else {
              Navigator.pop(context);
            }
          },
        ),
        ListTile(
          title: const Text('My Recipes'),
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != '/myrecipes') {
              Navigator.pushReplacementNamed(context, '/myrecipes');
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}
