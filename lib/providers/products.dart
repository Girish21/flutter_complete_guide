import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  static const API = 'https://shop-app-ab094.firebaseio.com/';

  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favorites {
    return _products
        .where(
          (element) => element.isFavorite,
        )
        .toList();
  }

  Product findById(String id) {
    return _products.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        '$API/products.json',
      );
      if (response.statusCode == 200) {
        _products = [];

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        responseBody.forEach((key, value) {
          final product = Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: value['isFavorite'],
          );

          _products = [..._products, product];
        });
      }
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<bool> addProduct(Product product) async {
    var success = false;

    try {
      final res = await http.post(
        '$API/products.json',
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final _product = Product(
          id: body['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );

        _products = [_product, ..._products];
        success = true;
      }

      notifyListeners();
      return success;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> updateProduct(Product product) async {
    var success = false;

    try {
      final response = await http.patch(
        '$API/products/${product.id}.json',
        body: jsonEncode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      if (response.statusCode == 200) {
        success = true;

        final indexToUpdate =
            _products.indexWhere((element) => element.id == product.id);

        _products = [
          ..._products.sublist(0, indexToUpdate),
          product,
          ..._products.sublist(indexToUpdate + 1)
        ];
        notifyListeners();
      }
      return success;
    } catch (e) {
      throw e;
    }
  }

  void deleteProduct(String id) {
    final indexToDelete = _products.indexWhere((element) => element.id == id);

    _products = [
      ..._products.sublist(0, indexToDelete),
      ..._products.sublist(indexToDelete + 1)
    ];

    notifyListeners();
  }
}
