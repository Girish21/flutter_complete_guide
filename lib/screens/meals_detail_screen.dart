import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../dummy_data.dart';
import '../models/meal_detail_argument.dart';

class MealDetail extends StatelessWidget {
  static const MealDetailRoute = '/detail';

  List<Widget> _buildTitleWidget(BuildContext context, String text) {
    return [
      const SizedBox(
        height: 24,
      ),
      Container(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      const SizedBox(
        height: 24,
      ),
    ];
  }

  Widget _buildContainer(BuildContext context, Meal meal, Widget child) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      padding: EdgeInsets.all(
        8,
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MealDetailArgument detail = ModalRoute.of(context).settings.arguments;
    final meal = DUMMY_MEALS[DUMMY_MEALS.indexWhere(
      (element) => element.id == detail.id,
    )];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${meal.title}',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () => Navigator.of(context).pop(
              detail.id,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            ..._buildTitleWidget(context, 'Ingredients'),
            _buildContainer(
              context,
              meal,
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  color: Theme.of(context).accentColor,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      meal.ingredients[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                itemCount: meal.ingredients.length,
                shrinkWrap: true,
              ),
            ),
            ..._buildTitleWidget(context, 'Steps'),
            _buildContainer(
              context,
              meal,
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '${index + 1}',
                        ),
                      ),
                      title: Text(
                        meal.steps[index],
                      ),
                    ),
                    if (index < meal.steps.length - 1)
                      Divider(
                        indent: 4,
                        endIndent: 4,
                        height: 1,
                      )
                  ],
                ),
                itemCount: meal.steps.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
