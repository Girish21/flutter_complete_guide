import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/meals_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(
          255,
          254,
          229,
          1,
        ),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(
                  20,
                  51,
                  51,
                  1,
                ),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(
                  20,
                  51,
                  51,
                  1,
                ),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMeals.CategoryMealsRoute: (ctx) => CategoryMeals(),
        MealDetail.MealDetailRoute: (ctx) => MealDetail(),
      },
    );
  }
}
