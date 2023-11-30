class Recipe {
  String title;
  // Other properties...

  Recipe({required this.title});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? '',
      // Assign other properties based on the JSON structure
    );
  }

  @override
  String toString() {
    return 'Recipe(title: $title)';
    // Add other properties if you want to include them in the output
  }
}
