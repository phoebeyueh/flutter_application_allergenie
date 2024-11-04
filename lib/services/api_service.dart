import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe_request.dart';
import '../models/recipe_response.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000';

  Future<RecipeResponse?> generateRecipe(RecipeRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate-recipe/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return RecipeResponse.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to load recipe: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}