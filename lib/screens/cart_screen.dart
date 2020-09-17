import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart' as widget;

class ShoppingCart extends StatefulWidget {
  static const RouteName = '/cart';

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var orderSubmitted = false;

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
                      '\$${_cart.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        orderSubmitted = true;
                      });
                      Provider.of<Orders>(context, listen: false)
                          .addOrder(
                        cartItems,
                        _cart.totalPrice,
                      )
                          .then((value) {
                        if (value)
                          Provider.of<Cart>(context, listen: false).clear();
                        else
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Order not submitted',
                              ),
                            ),
                          );
                      });
                    },
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
              itemBuilder: (context, index) => widget.CartItem(
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
