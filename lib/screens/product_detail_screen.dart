import 'package:flutter/material.dart';

import '../models/product_detail_argument.dart';

class ProductDetail extends StatelessWidget {
  static const RouteName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final ProductDetailArgument product =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.id,
        ),
      ),
    );
  }
}
