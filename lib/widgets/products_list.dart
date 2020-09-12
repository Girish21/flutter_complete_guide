import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_card.dart';
import '../providers/products.dart';

class ProductsList extends StatelessWidget {
  final bool showFavorites;

  const ProductsList({
    Key key,
    this.showFavorites = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    final _products =
        showFavorites ? productsProvider.favorites : productsProvider.products;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
        mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
      ),
      padding: const EdgeInsets.all(
        16,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];

        return ChangeNotifierProvider.value(
          value: product,
          child: ProductCard(),
        );
      },
    );
  }
}
