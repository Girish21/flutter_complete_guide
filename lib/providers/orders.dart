import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './api.dart';
import './cart.dart';

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

  Future<bool> addOrder(List<CartItem> products, double total) async {
    var success = false;

    try {
      final response = await http.post(
        '${Api.API}/orders.json',
        body: jsonEncode({
          'amount': total,
          'products': jsonEncode(products),
          'dateTime': DateTime.now().toString(),
        }),
      );
      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];

        _orders = [
          OrderItem(
            id: id,
            amount: total,
            products: products,
            dateTime: DateTime.now(),
          ),
          ..._orders
        ];
        success = true;

        notifyListeners();
      }
      return success;
    } catch (e) {
      throw e;
    }
  }
}
