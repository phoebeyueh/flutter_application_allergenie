import 'package:flutter/material.dart';
import '../models/recipe_request.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _questionController = TextEditingController();
  final ApiService _apiService = ApiService();
  String _recipe = "";
  bool _isLoading = false; 

  Future<void> _getRecipe() async {
    if (_questionController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final request = RecipeRequest(question: _questionController.text);
    final response = await _apiService.generateRecipe(request);

    setState(() {
      _recipe = response?.recipe ?? "No recipe found.";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            // Question Banner
            _buildBanner(),
            const SizedBox(height: 16),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Ask for a recipe (e.g., allergy-friendly)',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 122, 70, 131)), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                  borderSide: const BorderSide(color: Color.fromARGB(255, 122, 70, 131)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 122, 70, 131), width: 2.0),
                ),
                filled: true,
                fillColor: Colors.purple[50], 
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getRecipe,
              child: const Text('Generate Recipe', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 122, 70, 131), 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
              ),
            ),
            // Spinner Animation
            const SizedBox(height: 16),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 122, 70, 131)), 
                    ),
                  )
                : Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(10.0), 
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 8.0,
                            offset: Offset(0, 4), 
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              _recipe,
                              style: const TextStyle(fontSize: 12), 
                            ),
                            const SizedBox(height: 16),
                            if (_recipe.isNotEmpty) _buildDisclaimerBanner(),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Banner with our logo and title
  Widget _buildBanner() {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 100, 
            fit: BoxFit.contain, 
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'AllerGenie Recipe Generator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 122, 70, 131),
          ),
        ),
      ],
    );
  }

  // Disclaimer Banner
  Widget _buildDisclaimerBanner() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0), 
      decoration: BoxDecoration(
        color: Colors.yellow[100], 
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.orange, width: 2.0), 
      ),
      child: const Text(
        "Disclaimer: For optimal safety and accuracy, we recommend consulting with your healthcare provider regarding the suitability of AllerGenie's recipe to avoid any potential health risks.",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold, 
          color: Colors.black, 
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}