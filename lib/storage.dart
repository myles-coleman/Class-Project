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
        'image': recipe.imageUrl,
        'extendedIngredients': recipe.extendedIngredients
            .map((ingredient) => ingredient.toJson())
            .toList(),
        'instructions': recipe.instructions,
        'userId': user!.uid,
        'isFavorite': recipe.isFavorite,
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

  Future<bool> deleteRecipe(String recipeId) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("Recipes").doc(recipeId).delete();
      if (kDebugMode) {
        print("Recipe deleted successfully: $recipeId");
      }
      return true;
    } catch (error) {
      if (kDebugMode) {
        print("Failed to delete Recipe: $error");
      }
      return false;
    }
  }

  Stream<List<Recipe>> fetchOwnedRecipesAsStream() {
    try {
      if (!isInitialized) {
        initializeDefault();
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      return firestore
          .collection('Recipes')
          .where('userId', isEqualTo: user!.uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return Recipe.fromJson(data);
        }).toList();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Stream.value([]);
    }
  }

  Future<List<Recipe>> fetchOwnedRecipes() async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('Recipes')
          .where('userId', isEqualTo: user!.uid)
          .get();

      List<Recipe> ownedRecipes = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Recipe.fromJson(data);
      }).toList();

      return ownedRecipes;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
