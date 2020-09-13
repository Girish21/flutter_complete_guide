import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CardItem({
    Key key,
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(
        id,
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Are you sure?',
              ),
              content: Text(
                'Do you want to remove the item from the cart?',
              ),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(20),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('\$${price.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(
              title,
            ),
            subtitle: Text('\$${(price * quantity).toStringAsFixed(2)}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}
