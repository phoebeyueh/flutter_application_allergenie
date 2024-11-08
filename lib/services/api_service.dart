import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe_request.dart';
import '../models/recipe_response.dart';

class ApiService {
  // Local URL
  final String baseUrl = 'http://127.0.0.1:8000';

  Future<RecipeResponse?> generateRecipe(RecipeRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate-recipe/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['recipe'] is List) {
          return RecipeResponse.fromJson(responseBody);
        } else {
          responseBody['recipe'] = [responseBody['recipe']];
          return RecipeResponse.fromJson(responseBody);
        }
      } else {
        print('Failed to load recipe: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}