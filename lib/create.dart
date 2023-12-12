import 'package:flutter/material.dart';
import 'package:classproject/components/recpie.dart';
import 'package:classproject/storage.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final RecipeStorage storage = RecipeStorage();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final List<Ingredient> _ingredients = [];
  late Recipe recipe;

  void _submitRecipe() {
    List<Ingredient> ingredients = _ingredients
        .map((ingredient) => Ingredient(
              id: 0,
              aisle: '',
              image: '',
              name: '',
              amount: 0,
              unit: '',
              unitShort: '',
              unitLong: '',
              originalString: ingredient.originalString,
              metaInformation: [],
            ))
        .toList();

    recipe = Recipe(
      id: 0,
      title: _titleController.text,
      imageUrl: 'https://spoonacular.com/recipeImages/default-image.jpg',
      imageType: '',
      nutrition: Nutrition(nutrients: []),
      extendedIngredients: ingredients,
      instructions: _instructionsController.text,
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
      isFavorite: true,
    );

    _titleController.clear();
    _instructionsController.clear();
    _ingredients.clear();
    _ingredientController.clear();
  }

  Widget buttons(BuildContext context) {
    return Row(
      children: [
        const Text('Create Recipe'),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              _submitRecipe();
              storage.writeRecipe(recipe);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.done,
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
        title: buttons(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://spoonacular.com/recipeImages/default-image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recipe Name'),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter Recipe Name',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recipe Instructions'),
            TextField(
              controller: _instructionsController,
              decoration: const InputDecoration(
                hintText: 'Enter Instructions',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recipe Ingredients'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_ingredients[index].originalString),
                );
              },
            ),
            TextField(
              controller: _ingredientController,
              decoration: const InputDecoration(
                hintText: 'Enter Ingredients',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.black),
              ),
              onEditingComplete: () {
                setState(() {
                  _ingredients.add(
                    Ingredient(
                        originalString: _ingredientController.text,
                        id: 0,
                        aisle: '',
                        name: '',
                        image: '',
                        amount: 0,
                        unit: '',
                        unitShort: '',
                        unitLong: '',
                        metaInformation: []),
                  );
                  _ingredientController.clear();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
