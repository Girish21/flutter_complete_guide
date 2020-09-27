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
      // appBar: AppBar(
      //   title: ,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _product.title,
              ),
              background: Hero(
                tag: _product.id,
                child: Image.network(
                  _product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '\$${_product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: double.infinity,
                      child: Text(
                        _product.description,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
