import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/widgets/meals_list.dart';

import '../models/category_meals_arguments.dart';
import '../models/meal_detail_argument.dart';
import '../screens/meals_detail_screen.dart';

class CategoryMeals extends StatefulWidget {
  static const CategoryMealsRoute = '/recipes';

  final List<Meal> meals;

  const CategoryMeals({
    Key key,
    @required this.meals,
  }) : super(key: key);

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
    setState(() {
      _neglectId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CategoryMealsArgument _arguments =
        ModalRoute.of(context).settings.arguments;

    final _filteredCategoryMeals = widget.meals
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
      body: MealsList(
        clickHandler: clickHandler,
        filteredCategoryMeals: _filteredCategoryMeals,
      ),
    );
  }
}
