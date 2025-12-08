import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'package:provider/provider.dart';
import '../services/favorites_services.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  double _scale = 1.0;

  void _toggleFavorite(FavoritesService favoritesService) {
    if (favoritesService.isFavorite(widget.meal)) {
      favoritesService.removeFavorite(widget.meal);
    } else {
      favoritesService.addFavorite(widget.meal);
    }

    setState(() {
      _scale = 1.3;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        shadowColor: Colors.black26,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.meal.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),

            // Името на јадењето долу
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Text(
                  widget.meal.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => _toggleFavorite(favoritesService),
                child: AnimatedScale(
                  scale: _scale,
                  duration: Duration(milliseconds: 100),
                  child: Icon(
                    favoritesService.isFavorite(widget.meal)
                        ? Icons.favorite
                        : Icons.favorite,
                    color: favoritesService.isFavorite(widget.meal)
                        ? Colors.redAccent
                        : Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
