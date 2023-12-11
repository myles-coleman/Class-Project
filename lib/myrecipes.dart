import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:classproject/components/recpie.dart';
import 'package:classproject/components/details.dart';
import 'package:classproject/components/drawer.dart';
import 'package:classproject/storage.dart';

class MyRecipesRoute extends StatefulWidget {
  const MyRecipesRoute({super.key});

  @override
  State<MyRecipesRoute> createState() => _MyRecipesRouteState();
}

class _MyRecipesRouteState extends State<MyRecipesRoute> {
  final List<Recipe> _ownedRecipes = [];
  final List<Recipe> _favoriteRecipes = [];
  final RecipeStorage storage = RecipeStorage();
  //add owned recipes to favorite recipes
  //owned recipes stay in the list even when not favorited

  @override
  void initState() {
    super.initState();
    // on page load, fetch the user's recipes with a function
    // store them in _ownedRecipes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
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
      body: Column(
        children: [
          if (_ownedRecipes.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _ownedRecipes.length,
                itemBuilder: (context, index) {
                  Recipe recipe = _favoriteRecipes[index];
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
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
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
            // Show a message or any other content when there are no search results
            const Expanded(
              child: Center(
                child: Text('No search results'),
              ),
            ),

          // Show a button or any other content when the user is signed in
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
