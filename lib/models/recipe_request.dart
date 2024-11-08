class RecipeRequest {
  final String allergy;
  final String dish_type;
  final int num_recipes;

  RecipeRequest({
    required this.allergy,
    required this.dish_type,
    required this.num_recipes,
  });

  Map<String, dynamic> toJson() {
    return {
      'allergy': allergy,
      'dish_type': dish_type,
      'num_recipes': num_recipes,
    };
  }

  @override
  String toString() {
    return 'RecipeRequest{allergy: $allergy, dish_type: $dish_type, num_recipes: $num_recipes}';
  }
}