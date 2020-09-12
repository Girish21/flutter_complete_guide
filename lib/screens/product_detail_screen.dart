import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_detail_argument.dart';
import '../providers/products.dart';

class ProductDetail extends StatelessWidget {
  static const RouteName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final ProductDetailArgument product =
        ModalRoute.of(context).settings.arguments;

    final productsProvider = Provider.of<Products>(context);

    final _product = productsProvider.products
        .where(
          (element) => element.id == product.id,
        )
        .elementAt(0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _product.title,
        ),
      ),
    );
  }
}
