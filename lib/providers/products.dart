import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './api.dart';
import './product.dart';

class Products with ChangeNotifier {
  final String _token;
  final String _userId;

  List<Product> _products;

  Products({
    @required token,
    @required products,
    @required userId,
  })  : _products = products,
        _token = token,
        _userId = userId;

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

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterQuery =
        filterByUser ? '&orderBy="creatorId"&equalTo="$_userId"' : '';
    try {
      final response = await http.get(
        '${Api.API}/products.json?auth=$_token$filterQuery',
      );
      if (response.statusCode == 200) {
        _products = [];
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody == null) {
          notifyListeners();
          return;
        }
        final favoriteReponse = await http
            .get('${Api.API}/user_favorites/$_userId.json?auth=$_token');

        final favoritesBody = jsonDecode(
            favoriteReponse.body != null ? favoriteReponse.body : {});

        responseBody.forEach((key, value) async {
          final product = Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite:
                favoritesBody != null ? favoritesBody[key] ?? false : false,
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
        '${Api.API}/products.json?auth=$_token',
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'creatorId': _userId,
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
        '${Api.API}/products/${product.id}.json?auth=$_token',
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

  Future<void> deleteProduct(String id) async {
    final indexToDelete = _products.indexWhere((element) => element.id == id);

    final response = await http.delete(
      '${Api.API}/products/$id.json?auth=$_token',
    );

    if (response.statusCode == 200) {
      _products = [
        ..._products.sublist(0, indexToDelete),
        ..._products.sublist(indexToDelete + 1)
      ];

      notifyListeners();
    }
  }
}
