import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_services.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesService>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text('Омилени рецепти')),
      body: favorites.isEmpty
          ? Center(child: Text('Немате омилени рецепти'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final meal = favorites[index];
          return MealCard(
            meal: meal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MealDetailScreen(mealId: meal.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
