import 'package:flutter/material.dart';
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
  var showFavorite = false;

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
                    showFavorite = false;
                  });
                  break;
                case FilterOptions.Favorites:
                  setState(() {
                    showFavorite = true;
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
        ],
      ),
      body: ProductsList(
        showFavorite: showFavorite,
      ),
    );
  }
}
