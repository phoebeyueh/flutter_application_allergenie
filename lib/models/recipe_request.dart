class RecipeRequest {
  final String question;

  RecipeRequest({required this.question});

  Map<String, dynamic> toJson() => {
        "question": question,
      };
}
