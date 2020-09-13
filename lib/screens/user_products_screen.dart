import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product.dart';

class UserProducts extends StatelessWidget {
  static const RouteName = '/products';

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            final products = _products.products;

            if (index < products.length - 1) return Divider();
            return null;
          },
          itemCount: _products.products.length,
          itemBuilder: (context, index) {
            final product = _products.products[index];

            return UserProductItem(
              title: product.title,
              imageUrl: product.imageUrl,
            );
          },
        ),
      ),
    );
  }
}
