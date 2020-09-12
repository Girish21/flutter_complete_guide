import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/products_list.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverview extends StatelessWidget {
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
    final setShowFavorite =
        Provider.of<Products>(context, listen: false).setShowFavorite;

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
                  setShowFavorite(false);
                  break;
                case FilterOptions.Favorites:
                  setShowFavorite(true);
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
        ],
      ),
      body: ProductsList(),
    );
  }
}
