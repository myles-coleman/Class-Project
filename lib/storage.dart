import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:classproject/components/recpie.dart';

class RecipeStorage {
  bool _initialized = false;
  RecipeStorage();

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default app $app");
    }
  }

  bool get isInitialized => _initialized;

  Future<bool> writeRecipe(Recipe recipe) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("recipes").doc(recipe.id.toString()).set({
        'id': recipe.id,
        'title': recipe.title,
        'imageUrl': recipe.imageUrl,
        'extendedIngredients': recipe.extendedIngredients,
        'instructions': recipe.instructions,
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

  Future<Recipe> readRecipe(String recipeId) async {
    Recipe recipe = Recipe(
      id: 0,
      title: '',
      imageUrl: '',
      imageType: '',
      nutrition: Nutrition(nutrients: []),
      extendedIngredients: [],
      instructions: '',
      readyInMinutes: 0,
      servings: 0,
      sourceUrl: '',
      spoonacularSourceUrl: '',
      weightWatcherSmartPoints: 0,
      vegetarian: false,
      vegan: false,
      glutenFree: false,
      dairyFree: false,
      veryHealthy: false,
      cheap: false,
      veryPopular: false,
      sustainable: false,
      lowFodmap: false,
      ketogenic: false,
      whole30: false,
      aggregateLikes: 0,
      creditText: '',
      sourceName: '',
    );

    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot ds =
          await firestore.collection('Recipes').doc(recipeId).get();

      if (ds.exists && ds.data() != null) {
        Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
        recipe = Recipe.fromJson(data);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return recipe;
  }
}
