import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './edit_product.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product.dart';

class UserProducts extends StatelessWidget {
  static const RouteName = '/products';

  Future _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProduct.RouteName,
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        8,
                      ),
                      child: Consumer<Products>(
                        builder: (context, value, child) => ListView.separated(
                          separatorBuilder: (context, index) {
                            final products = value.products;

                            if (index < products.length - 1) return Divider();
                            return null;
                          },
                          itemCount: value.products.length,
                          itemBuilder: (context, index) {
                            final product = value.products[index];

                            return UserProductItem(
                              id: product.id,
                              title: product.title,
                              imageUrl: product.imageUrl,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
