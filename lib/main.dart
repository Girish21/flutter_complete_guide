import 'package:flutter/material.dart';

import './screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      routes: {
        '/': (ctx) => ProductsOverview(),
      },
    );
  }
}
