import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:classproject/components/recpie.dart';
import 'package:classproject/components/details.dart';
import 'package:classproject/components/drawer.dart';
import 'package:classproject/storage.dart';
import 'package:classproject/create.dart';

class MyRecipesRoute extends StatefulWidget {
  const MyRecipesRoute({super.key});

  @override
  State<MyRecipesRoute> createState() => _MyRecipesRouteState();
}

class _MyRecipesRouteState extends State<MyRecipesRoute> {
  final RecipeStorage storage = RecipeStorage();

  Widget createRecipeButton(BuildContext context) {
    return Row(
      children: [
        const Text('My Recipes'),
        Expanded(
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateRecipe(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: createRecipeButton(context),
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
          StreamBuilder<List<Recipe>>(
            stream: storage.fetchOwnedRecipesAsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('No recipes available.');
              } else {
                List<Recipe> ownedRecipes = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: ownedRecipes.length,
                    itemBuilder: (context, index) {
                      Recipe recipe = ownedRecipes[index];
                      if (kDebugMode) {
                        print(recipe.imageUrl);
                      }
                      return InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(recipe: recipe),
                            ),
                          );
                          storage.fetchOwnedRecipes();
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
                                errorBuilder: (context, error, stackTrace) {
                                  if (kDebugMode) {
                                    print('Error loading image: $error');
                                  }
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
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
