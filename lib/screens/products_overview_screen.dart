import 'package:flutter/material.dart';
import '../widgets/products_list.dart';

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shop',
        ),
      ),
      body: ProductsList(),
    );
  }
}
