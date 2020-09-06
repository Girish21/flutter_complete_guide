import 'package:flutter/material.dart';
import './categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      home: HomeComponent(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.brown,
      ),
    );
  }
}

class HomeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Categories();
  }
}
