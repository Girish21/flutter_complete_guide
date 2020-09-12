import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart' as ord;

class OrdersScreen extends StatelessWidget {
  static const RouteName = '/orders';

  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => ord.OrderItem(
          order: _orders.orders[index],
        ),
        itemCount: _orders.orders.length,
      ),
    );
  }
}
