import 'package:flutter/material.dart';
import '../models/meal_detail_argument.dart';

class MealDetail extends StatelessWidget {
  static const MealDetailRoute = '/detail';

  @override
  Widget build(BuildContext context) {
    final MealDetailArgument detail = ModalRoute.of(context).settings.arguments;
    return Center(
      child: Text(
        detail.category,
      ),
    );
  }
}
