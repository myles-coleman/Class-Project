import 'package:flutter/material.dart';

class createRecipe extends StatefulWidget {
  const createRecipe({super.key});

  @override
  State<createRecipe> createState() => _createRecipeState();
}

class _createRecipeState extends State<createRecipe> {
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

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
            onTap: () {},
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
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                hintText: 'Enter Ingredients',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
