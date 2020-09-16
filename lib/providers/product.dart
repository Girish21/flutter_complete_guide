import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './api.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    final prevState = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(
      '${Api.API}/products/$id.json',
      body: jsonEncode({
        'isFavorite': isFavorite,
      }),
    );
    if (response.statusCode != 200) {
      isFavorite = prevState;
      notifyListeners();
    }
  }
}
