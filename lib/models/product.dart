import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constats.dart';

class Product with ChangeNotifier {
  String? description, imageUrl;
  double price;
  String id, name;
  bool isFavorite;

  Product({
    required this.id,
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

  Future<void> toggleFavorite(String token, String uId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
        Uri.parse('${Constants.userFavoriteUrl}/$uId/$id.json?auth=$token'),
        body: jsonEncode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (e) {
      _toggleFavorite();
    }
  }
}
