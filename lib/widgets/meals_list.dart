import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_tile.dart';

class MealsList extends StatelessWidget {
  final List<Meal> filteredCategoryMeals;
  final Function clickHandler;

  const MealsList({
    Key key,
    this.filteredCategoryMeals,
    this.clickHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredCategoryMeals.length,
      itemBuilder: (context, index) {
        final element = filteredCategoryMeals[index];
        return MealTile(
          affordability: element.affordability,
          complexity: element.complexity,
          id: element.id,
          imageUrl: element.imageUrl,
          title: element.title,
          duration: element.duration,
          clickHandler: clickHandler,
        );
      },
    );
  }
}
