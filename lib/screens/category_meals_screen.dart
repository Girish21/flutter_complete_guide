import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category_meals_arguments.dart';
import '../models/meal_detail_argument.dart';
import '../screens/meals_detail_screen.dart';
import '../widgets/meal_tile.dart';

class CategoryMeals extends StatefulWidget {
  static const CategoryMealsRoute = '/recipes';

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String _neglectId;

  void clickHandler(context, id) async {
    final value = await Navigator.of(context).pushNamed(
      MealDetail.MealDetailRoute,
      arguments: MealDetailArgument(
        id: id,
      ),
    );
    setState(
      () {
        _neglectId = value;
      },
    );
  }

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
        .where(
            (element) => _neglectId != null ? element.id != _neglectId : true)
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
