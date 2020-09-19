import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_list.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverview extends StatefulWidget {
  static const RouteName = '/overview';

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var showFavorites = false;
  var init = true;
  var isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    init = false;
  }

  PopupMenuItem _buildPopupMenuItem(String text, FilterOptions value) {
    return PopupMenuItem(
      child: Text(
        text,
      ),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shop',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case FilterOptions.All:
                  setState(() {
                    showFavorites = false;
                  });
                  break;
                case FilterOptions.Favorites:
                  setState(() {
                    showFavorites = true;
                  });
                  break;
              }
            },
            itemBuilder: (_) => [
              _buildPopupMenuItem(
                'Only Favorites',
                FilterOptions.Favorites,
              ),
              _buildPopupMenuItem(
                'Show All',
                FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, value, child) => Badge(
              child: child,
              value: value.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  ShoppingCart.RouteName,
                );
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsList(
              showFavorites: showFavorites,
            ),
    );
  }
}
