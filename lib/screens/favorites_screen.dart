import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal_detail_argument.dart';
import 'package:flutter_complete_guide/screens/meals_detail_screen.dart';
import '../widgets/meals_list.dart';
import '../models/meal.dart';

class Favorites extends StatelessWidget {
  final List<Meal> favorites;

  const Favorites({
    Key key,
    @required this.favorites,
  }) : super(key: key);

  void clickHandler(
    BuildContext context,
    String id,
  ) {
    Navigator.of(context).pushNamed(
      MealDetail.MealDetailRoute,
      arguments: MealDetailArgument(
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return favorites.isEmpty
        ? Center(
            child: Text(
              'Favorites',
            ),
          )
        : MealsList(
            clickHandler: clickHandler,
            filteredCategoryMeals: favorites,
          );
  }
}
