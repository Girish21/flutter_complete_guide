import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category_meals_arguments.dart';
import '../widgets/meal_tile.dart';

class CategoryMeals extends StatelessWidget {
  static const CategoryMealsRoute = '/recipes';

  void clickHandler() {}

  @override
  Widget build(BuildContext context) {
    final CategoryMealsArgument _arguments =
        ModalRoute.of(context).settings.arguments;

    final _filteredCategoryMeals = DUMMY_MEALS
        .where(
          (element) => element.categories.contains(
            _arguments.id,
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _arguments.category,
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredCategoryMeals.length,
        itemBuilder: (context, index) {
          final element = _filteredCategoryMeals[index];
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
      ),
    );
  }
}
