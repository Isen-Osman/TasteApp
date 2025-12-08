import 'package:flutter/material.dart';
import '../models/meal.dart';

class FavoritesService extends ChangeNotifier {
  final List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  void addFavorite(Meal meal) {
    if (!_favorites.any((m) => m.id == meal.id)) {
      _favorites.add(meal);
      notifyListeners();
    }
  }

  void removeFavorite(Meal meal) {
    _favorites.removeWhere((m) => m.id == meal.id);
    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favorites.any((m) => m.id == meal.id);
  }
}
