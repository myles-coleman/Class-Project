import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ListTile(
          title: const Text('Home'),
          onTap: () {
            // Check if already on the Home page
            if (ModalRoute.of(context)?.settings.name != '/') {
              Navigator.pushNamed(context, '/');
            } else {
              // Do nothing or close the drawer
              Navigator.pop(context);
            }
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            // Check if already on the Settings page
            if (ModalRoute.of(context)?.settings.name != '/settings') {
              Navigator.pushNamed(context, '/settings');
            } else {
              // Do nothing or close the drawer
              Navigator.pop(context);
            }
          },
        ),
        ListTile(
          title: const Text('My Recipes'),
          onTap: () {
            // Check if already on the MyRecipes page
            if (ModalRoute.of(context)?.settings.name != '/myrecipes') {
              Navigator.pushNamed(context, '/myrecipes');
            } else {
              // Do nothing or close the drawer
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}
