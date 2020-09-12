import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    this.id,
    this.title,
    this.quantity,
    this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  var itemsInCart = 0;
  var total = 0.0;

  void addItem({
    String id,
    double price,
    String title,
  }) {
    itemsInCart++;
    total += price;

    if (_items.containsKey(id)) {
      _items.update(
        id,
        (value) => CartItem(
          id: value.id,
          price: value.price,
          quantity: value.quantity + 1,
          title: value.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: uuid.v4(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  int get itemCount {
    return itemsInCart;
  }

  double get totalPrice {
    return total;
  }

  void removeItem(String id) {
    var item = _items.remove(id);

    itemsInCart -= item.quantity;
    total -= item.quantity * item.price;

    notifyListeners();
  }

  void clear() {
    _items = {};
    itemsInCart = 0;
    total = 0.0;

    notifyListeners();
  }
}
