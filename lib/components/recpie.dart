import 'package:flutter/foundation.dart';

class Recipe {
  int id;
  String title;
  String imageUrl;
  String imageType;
  final Nutrition nutrition;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.imageType,
    required this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl:
          'https://spoonacular.com/recipeImages/${json['image'] ?? 'default-image.jpg'}',
      imageType: json['imageType'] ?? '',
      nutrition: json['nutrition'] != null
          ? Nutrition.fromJson(json['nutrition'])
          : Nutrition(
              nutrients: []), // Provide a default value if 'nutrition' is null
    );
  }

  @override
  String toString() {
    return 'Recipe(title: $title)';
  }
}

class Nutrition {
  final List<Nutrient> nutrients;

  Nutrition({required this.nutrients});

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print(json);
    }
    return Nutrition(
      nutrients: List<Nutrient>.from(
        json['nutrients']
            .map((nutrientJson) => Nutrient.fromJson(nutrientJson)),
      ),
    );
  }
}

class Nutrient {
  final String name;
  final double amount;
  final String unit;

  Nutrient({required this.name, required this.amount, required this.unit});

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      name: json['name'],
      amount: json['amount'].toDouble(),
      unit: json['unit'],
    );
  }

  @override
  String toString() {
    return 'Nutrient(name: $name, amount: $amount, unit: $unit)';
  }
}
