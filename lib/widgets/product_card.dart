import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_detail_argument.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<Product>(context, listen: false);
    final _cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        16,
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.RouteName,
              arguments: ProductDetailArgument(
                _product.id,
              ),
            );
          },
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => product.toggleFavorite(),
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            _product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added to cart',
                  ),
                  duration: Duration(
                    seconds: 5,
                  ),
                  action: SnackBarAction(
                    label: 'Confirm',
                    onPressed: () {
                      _cart.addItem(
                        id: _product.id,
                        price: _product.price,
                        title: _product.title,
                      );
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
