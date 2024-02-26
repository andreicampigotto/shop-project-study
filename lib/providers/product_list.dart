import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProdutcs;
  bool _showFavoriteOnly = false;

  List<Product> get products {
    if (_showFavoriteOnly) {
      return _products.where((product) => product.isFavorite).toList();
    }

    return [..._products];
  }

  void toggleShowFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void toggleShowAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
