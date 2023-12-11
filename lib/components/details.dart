import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classproject/components/recpie.dart';
import 'package:classproject/storage.dart';

class Details extends StatefulWidget {
  final Recipe recipe;

  const Details({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String displayContent = 'instructions'; // Default content to display
  bool isFavorite = false;
  String ingredients = '';

  @override
  void initState() {
    super.initState();
    // Fetch recipe information when the page loads
    fetchRecipeInformation();
  }

  Future<void> fetchRecipeInformation() async {
    const apiKey = 'ebd2997c2bmshaf4f87ff8121c4ep1494b1jsnf8a459f3a414';
    const apiUrl = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
    final uri = Uri.https(apiUrl, '/recipes/${widget.recipe.id}/information');

    Map<String, String> headers = {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': apiUrl,
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Update state variables with received data
        setState(() {
          widget.recipe.instructions =
              responseData['instructions'] ?? 'No instructions available';

          widget.recipe.extendedIngredients =
              responseData['extendedIngredients'];

          ingredients = (responseData['extendedIngredients'] as List<dynamic>)
              .map((ingredient) {
            return ingredient['original'];
          }).join('\n');
        });
      } else {
        throw Exception('Failed to load recipe information');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> sentences = widget.recipe.instructions.split('. ');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image at the top with aspect ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      displayContent = 'instructions';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 2),
                    backgroundColor:
                        displayContent == 'instructions' ? Colors.black : null,
                  ),
                  child: const Text('Instructions'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      displayContent = 'ingredients';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 2),
                    backgroundColor:
                        displayContent == 'ingredients' ? Colors.black : null,
                  ),
                  child: const Text('Ingredients'),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      final RecipeStorage recipeStorage = RecipeStorage();
                      recipeStorage.writeRecipe(widget.recipe);
                      if (kDebugMode) {
                        print('favorited recipe: ${widget.recipe.id}');
                      }
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (displayContent == 'instructions')
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < sentences.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${i + 1}.',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                sentences[i],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            if (displayContent == 'ingredients')
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  ingredients,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
