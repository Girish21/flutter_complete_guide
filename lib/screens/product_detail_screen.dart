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

    final productsProvider = Provider.of<Products>(
      context,
      listen: false,
    );

    final _product = productsProvider.findById(
      product.id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _product.title,
        ),
      ),
    );
  }
}
