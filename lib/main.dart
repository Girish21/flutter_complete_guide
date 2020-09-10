import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meals_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _filters = {
    'glutten': false,
    'vegitarian': false,
    'vegan': false,
    'lactose': false,
  };

  var listData = DUMMY_MEALS;

  void saveFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      listData = DUMMY_MEALS.where((element) {
        if (_filters['glutten'] && !element.isGlutenFree) return false;
        if (_filters['vegitarian'] && !element.isVegetarian) return false;
        if (_filters['vegan'] && !element.isVegan) return false;
        if (_filters['lactose'] && !element.isLactoseFree) return false;
        return true;
      }).toList();
    });
  }

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
        CategoryMeals.CategoryMealsRoute: (ctx) => CategoryMeals(
              meals: listData,
            ),
        MealDetail.MealDetailRoute: (ctx) => MealDetail(),
        Filters.FiltersRoute: (ctx) => Filters(
              saveFilters: saveFilters,
              filters: _filters,
            ),
      },
    );
  }
}
