class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final String youtube;
  final Map<String, String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.instructions = '',
    this.youtube = '',
    this.ingredients = const {},
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    Map<String, String> ingredientsMap = {};
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsMap[ingredient] = measure ?? '';
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      instructions: json['strInstructions'] ?? '',
      youtube: json['strYoutube'] ?? '',
      ingredients: ingredientsMap,
    );
  }
}