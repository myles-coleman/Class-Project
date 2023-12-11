import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classproject/components/recpie.dart';

class Details extends StatefulWidget {
  final Recipe recipe;

  const Details({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String displayContent = 'instructions'; // Default content to display
  bool isFavorite = false;

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
      'x-rapidapi-host': apiUrl
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Process the responseData as needed
        if (kDebugMode) {
          print(responseData);
        }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: Column(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          backgroundColor: displayContent == 'instructions'
                              ? Colors.black
                              : null,
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
                          backgroundColor: displayContent == 'ingredients'
                              ? Colors.black
                              : null,
                        ),
                        child: const Text('Ingredients'),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
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
                  // Display content based on the button pressed
                  if (displayContent == 'instructions')
                    Text(
                      widget.recipe.instructions,
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (displayContent == 'ingredients')
                    const Text(
                      'something',
                      style: TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
