import 'package:flutter/material.dart';
import 'package:classproject/components/recpie.dart';

class Details extends StatelessWidget {
  final Recipe recipe;

  const Details({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              recipe.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text('Recipe Details: ${recipe.title}'),
            const SizedBox(height: 10),
            if (recipe.nutrition != null &&
                recipe.nutrition.nutrients.isNotEmpty)
              const Text('Nutrition: '),
            for (Nutrient nutrient in recipe.nutrition.nutrients)
              Text('${nutrient.name}: ${nutrient.amount} ${nutrient.unit}'),
          ],
        ),
      ),
    );
  }
}
