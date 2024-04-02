import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constats.dart';

class Product with ChangeNotifier {
  String? id, description, imageUrl;
  double price;
  bool isFavorite;
  String name;

  Product({
    this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.price = 0.00,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    try {
      _toggleFavorite();
      final response = await http.patch(
        Uri.parse('${Constants.productBaseUrl}/$id.json'),
        body: jsonEncode({'isFavourite': !isFavorite}),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (e) {
      _toggleFavorite();
    }
  }
}
