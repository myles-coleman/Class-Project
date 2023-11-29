class Recipe {
  String name;
  // Other properties...

  Recipe({required this.name});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      // Assign other properties based on the JSON structure
    );
  }
}
