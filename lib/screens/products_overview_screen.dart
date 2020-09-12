import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/products_list.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var showFavorites = false;

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
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ProductsList(
        showFavorites: showFavorites,
      ),
    );
  }
}
