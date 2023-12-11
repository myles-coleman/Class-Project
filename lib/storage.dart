import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:classproject/components/recpie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeStorage {
  bool _initialized = false;
  bool get isInitialized => _initialized;
  RecipeStorage();
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default app $app");
    }
  }

  Future<bool> writeRecipe(Recipe recipe) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("Recipes").doc(recipe.id.toString()).set({
        'id': recipe.id,
        'title': recipe.title,
        'imageUrl': recipe.imageUrl,
        'extendedIngredients': recipe.extendedIngredients
            .map((ingredient) =>
                ingredient.toJson()) // Convert Ingredient to JSON
            .toList(),
        'instructions': recipe.instructions,
        'userId': user!.uid,
      });
      if (kDebugMode) {
        print("Recipe written successfully: ${recipe.id}");
      }
      return true;
    } catch (error) {
      if (kDebugMode) {
        print("Failed to write Recipe: $error");
      }
      return false;
    }
  }

  Future<bool> deleteRecipe(Recipe recipe) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("recipes").doc(recipe.id.toString()).delete();
      if (kDebugMode) {
        print("Recipe deleted successfully: ${recipe.id}");
      }
      return true;
    } catch (error) {
      if (kDebugMode) {
        print("Failed to delete Recipe: $error");
      }
      return false;
    }
  }

  Future<List<Recipe>> fetchOwnedRecipes() async {
    List<Recipe> ownedRecipes = [];

    try {
      if (!isInitialized) {
        await initializeDefault();
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('Recipes')
          .where('userId', isEqualTo: user!.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Recipe recipe = Recipe.fromJson(data);
        ownedRecipes.add(recipe);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return ownedRecipes;
  }
}
