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
  final String _token;
  List<OrderItem> _orders;

  Orders(this._token, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get('${Api.API}/orders.json?auth=$_token');

      if (response.statusCode == 200) {
        _orders = [];
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody == null) {
          notifyListeners();
          return;
        }

        List<OrderItem> _tempOrders = [];

        responseBody.forEach((key, value) {
          _tempOrders = [
            ..._tempOrders,
            OrderItem(
              id: key,
              amount: value['amount'],
              products: List<Map>.from(value['products'])
                  .map(
                    (e) => CartItem.fromJson(e),
                  )
                  .toList(),
              dateTime: DateTime.parse(value['dateTime']),
            ),
          ];
        });

        _orders = _tempOrders.reversed.toList();

        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> addOrder(List<CartItem> products, double total) async {
    var success = false;

    try {
      final response = await http.post(
        '${Api.API}/orders.json?auth=$_token',
        body: jsonEncode({
          'amount': total,
          'products': products.map((e) => e.toJson()).toList(),
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
