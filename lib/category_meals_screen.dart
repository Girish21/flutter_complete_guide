import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/category_meals_arguments.dart';

class CategoryMeals extends StatelessWidget {
  static const CategoryMealsRoute = '/recipes';
  @override
  Widget build(BuildContext context) {
    final CategoryMealsArgument _arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _arguments.category,
        ),
      ),
      body: Center(
        child: Text(
          'The Recipes for the category',
        ),
      ),
    );
  }
}
