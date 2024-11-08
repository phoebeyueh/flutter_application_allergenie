class RecipeResponse {
  final String question;
  final List<String> recipes;
  final int numRecipes;

  RecipeResponse({
    required this.question,
    required this.recipes,
    required this.numRecipes,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    var recipeList = (json['recipe'] as List<dynamic>).map((item) => item as String).toList();

    return RecipeResponse(
      question: json['question'],
      recipes: recipeList,
      numRecipes: json['num_recipes'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'recipe': recipes,
      'num_recipes': numRecipes,
    };
  }

  @override
  String toString() {
    return 'RecipeResponse{question: $question, recipes: $recipes, num_recipes: $numRecipes}';
  }
}