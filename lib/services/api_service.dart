import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Листа на категории
  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    final data = json.decode(response.body);
    return (data['categories'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  // Јадења по категорија
  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    final data = json.decode(response.body);
    return (data['meals'] as List)
        .map((json) => Meal.fromJson(json))
        .toList();
  }

  // Детален рецепт по id
  static Future<Meal> getMealDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    final data = json.decode(response.body);
    return Meal.fromJson(data['meals'][0]);
  }

  // Рандом рецепт
  static Future<Meal> getRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));
    final data = json.decode(response.body);
    return Meal.fromJson(data['meals'][0]);
  }

  // Пребарување рецепти
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    final data = json.decode(response.body);
    if (data['meals'] == null) return [];
    return (data['meals'] as List)
        .map((json) => Meal.fromJson(json))
        .toList();
  }
}
