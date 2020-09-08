import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category_meals_arguments.dart';

class CategoryMeals extends StatelessWidget {
  static const CategoryMealsRoute = '/recipes';
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
        itemBuilder: (context, index) => Container(
          child: Text(
            _filteredCategoryMeals[index].title,
          ),
        ),
      ),
    );
  }
}
