class Recipe {
  int id;
  String title;
  String imageUrl;
  String imageType;
  Nutrition nutrition;
  List<Ingredient> extendedIngredients;
  String instructions;
  int readyInMinutes;
  int servings;
  String sourceUrl;
  String spoonacularSourceUrl;
  int weightWatcherSmartPoints;
  bool vegetarian;
  bool vegan;
  bool glutenFree;
  bool dairyFree;
  bool veryHealthy;
  bool cheap;
  bool veryPopular;
  bool sustainable;
  bool lowFodmap;
  bool ketogenic;
  bool whole30;
  int aggregateLikes;
  String creditText;
  String sourceName;
  bool isFavorite = false;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.imageType,
    required this.nutrition,
    required this.extendedIngredients,
    required this.instructions,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.spoonacularSourceUrl,
    required this.weightWatcherSmartPoints,
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.lowFodmap,
    required this.ketogenic,
    required this.whole30,
    required this.aggregateLikes,
    required this.creditText,
    required this.sourceName,
    required this.isFavorite,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    String imageUrl = _processApiImageUrl(json['image']);
    return Recipe(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: imageUrl,
      imageType: json['imageType'] ?? '',
      nutrition: Nutrition.fromJson(json),
      extendedIngredients: List<Ingredient>.from((json['extendedIngredients']
                  as List<dynamic>?)
              ?.map((ingredientJson) => Ingredient.fromJson(ingredientJson)) ??
          []),
      instructions: json['instructions'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      sourceUrl: json['sourceUrl'] ?? '',
      spoonacularSourceUrl: json['spoonacularSourceUrl'] ?? '',
      weightWatcherSmartPoints: json['weightWatcherSmartPoints'] ?? 0,
      vegetarian: json['vegetarian'] ?? false,
      vegan: json['vegan'] ?? false,
      glutenFree: json['glutenFree'] ?? false,
      dairyFree: json['dairyFree'] ?? false,
      veryHealthy: json['veryHealthy'] ?? false,
      cheap: json['cheap'] ?? false,
      veryPopular: json['veryPopular'] ?? false,
      sustainable: json['sustainable'] ?? false,
      lowFodmap: json['lowFodmap'] ?? false,
      ketogenic: json['ketogenic'] ?? false,
      whole30: json['whole30'] ?? false,
      aggregateLikes: json['aggregateLikes'] ?? 0,
      creditText: json['creditText'] ?? '',
      sourceName: json['sourceName'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  static String _processApiImageUrl(String? imageUrl) {
    // Check if the URL has an HTTP header
    if (imageUrl != null &&
        (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'))) {
      return imageUrl;
    } else {
      // If no HTTP header is present, prepend the base URL for spoonacular
      return 'https://spoonacular.com/recipeImages/$imageUrl';
    }
  }
}

class Nutrition {
  final List<Nutrient> nutrients;

  Nutrition({required this.nutrients});

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    if (json['nutrients'] != null) {
      return Nutrition(
        nutrients: List<Nutrient>.from(
          json['nutrients']
              .map((nutrientJson) => Nutrient.fromJson(nutrientJson)),
        ),
      );
    } else {
      return Nutrition(nutrients: []);
    }
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
}

class Ingredient {
  int id;
  String aisle;
  String image;
  String name;
  double amount;
  String unit;
  String unitShort;
  String unitLong;
  String originalString;
  List<String> metaInformation;

  Ingredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.name,
    required this.amount,
    required this.unit,
    required this.unitShort,
    required this.unitLong,
    required this.originalString,
    required this.metaInformation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aisle': aisle,
      'image': image,
      'name': name,
      'amount': amount,
      'unit': unit,
      'unitShort': unitShort,
      'unitLong': unitLong,
      'originalString': originalString,
      'metaInformation': metaInformation,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] ?? 0,
      aisle: json['aisle'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      amount: json['amount']?.toDouble() ?? 0.0,
      unit: json['unit'] ?? '',
      unitShort: json['unitShort'] ?? '',
      unitLong: json['unitLong'] ?? '',
      originalString: json['original'] ?? 'Unknown Ingredient',
      metaInformation: List<String>.from(json['metaInformation'] ?? []),
    );
  }
}
