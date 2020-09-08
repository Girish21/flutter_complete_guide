import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import '../models/meal_detail_argument.dart';

class MealDetail extends StatelessWidget {
  static const MealDetailRoute = '/detail';

  @override
  Widget build(BuildContext context) {
    final MealDetailArgument detail = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal',
        ),
      ),
      body: Center(
        child: Text(
          DUMMY_MEALS[DUMMY_MEALS.indexWhere(
            (element) => element.id == detail.id,
          )]
              .title,
        ),
      ),
    );
  }
}
