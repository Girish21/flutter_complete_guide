import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  static const RouteName = '/cart';

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    final cartItemKey = _cart.items.keys.toList();
    final cartItems = _cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(
              16,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${_cart.totalPrice}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Order Now'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CardItem(
                id: cartItemKey[index],
                price: cartItems[index].price,
                quantity: cartItems[index].quantity,
                title: cartItems[index].title,
              ),
              itemCount: _cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
