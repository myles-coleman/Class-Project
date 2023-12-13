import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:classproject/components/recpie.dart';
import 'package:classproject/components/details.dart';
import 'package:classproject/components/drawer.dart';

//search bar code referenced from https://stackoverflow.com/questions/56346660/how-to-add-a-texfield-inside-the-app-bar-in-flutter

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Recipe> _searchResults = [];

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

    setState(() {
      _searchResults = results;
    });
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
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _showSearchOverlay();
            },
            icon: const Icon(Icons.search, color: Colors.black),
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
      drawer: Drawer(child: buildDrawer(context)),
      body: Column(
        children: [
          if (_searchResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  Recipe recipe = _searchResults[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(recipe: recipe),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: ListTile(
                        title: Text(recipe.title),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text('No search results'),
              ),
            ),
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return ElevatedButton(
                  child: const Text('Go to Login Page'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
