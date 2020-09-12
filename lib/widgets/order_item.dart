import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  const OrderItem({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat.yMMMd().format(
                order.dateTime,
              ),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.expand_more,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
