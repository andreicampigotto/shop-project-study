import 'package:flutter/material.dart';

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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
