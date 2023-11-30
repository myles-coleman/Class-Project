import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:classproject/components/recpie.dart';

//search bar code referenced from https://stackoverflow.com/questions/56346660/how-to-add-a-texfield-inside-the-app-bar-in-flutter

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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

  Future<List<Recipe>> searchRecipes(String query) async {
    const apiKey = 'ebd2997c2bmshaf4f87ff8121c4ep1494b1jsnf8a459f3a414';
    const apiUrl = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
    final uri = Uri.https(apiUrl, '/recipes/search', {'query': query});

    Map<String, String> headers = {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': apiUrl
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  void _showSearchOverlay() async {
    _searchQuery = _searchController.text;
    final results = await searchRecipes(_searchQuery);
    // Display the search results in your UI, you can use a BottomSheet, Dialog, or navigate to a new screen.
    if (kDebugMode) {
      print(results);
    }
  }

  Widget textBox(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for recipes',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _showSearchOverlay();
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textBox(context),
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
