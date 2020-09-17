import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart' as ord;

class OrdersScreen extends StatefulWidget {
  static const RouteName = '/orders';

  const OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var initCall = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (initCall) {
      Provider.of<Orders>(context, listen: false).fetchOrders();
    }
    initCall = false;
  }

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
