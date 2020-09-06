import 'package:flutter/material.dart';

import './category_meals_screen.dart';
import './models/category_meals_arguments.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryTile({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      25,
    );

    return InkWell(
      splashColor: Theme.of(context).primaryColorDark,
      borderRadius: borderRadius,
      onTap: () => Navigator.of(context).pushNamed(
        CategoryMeals.CategoryMealsRoute,
        arguments: CategoryMealsArgument(
          title,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
