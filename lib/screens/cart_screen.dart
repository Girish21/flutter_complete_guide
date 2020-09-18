import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart' as cartWidget;

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
                      '\$${_cart.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  OrderButton(cartItems: cartItems, cart: _cart),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => cartWidget.CartItem(
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartItems,
    @required this.cart,
  }) : super(key: key);

  final List<CartItem> cartItems;
  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var submitting = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.cart.totalPrice == 0 || submitting
          ? null
          : () {
              setState(() {
                submitting = true;
              });
              Provider.of<Orders>(
                context,
                listen: false,
              )
                  .addOrder(
                widget.cartItems,
                widget.cart.totalPrice,
              )
                  .then((value) {
                setState(() {
                  submitting = false;
                });
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
      child: submitting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Text(
              'Order Now',
            ),
      textColor: Theme.of(context).primaryColor,
    );
  }
}
