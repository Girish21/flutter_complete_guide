import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './cart.dart';

final uuid = Uuid();

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double total) {
    _orders = [
      OrderItem(
        id: uuid.v4(),
        amount: total,
        products: products,
        dateTime: DateTime.now(),
      ),
      ..._orders
    ];

    notifyListeners();
  }
}
