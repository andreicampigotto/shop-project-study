import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String? id, description, imageUrl;
  double price;
  bool favorite;
  String title;

  Product({
    this.id,
    required this.title,
    this.imageUrl,
    this.description,
    this.price = 0.00,
    this.favorite = false,
  });

  void toggleFavorite() {
    favorite = !favorite;
    notifyListeners();
  }
}
