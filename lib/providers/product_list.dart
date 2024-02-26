import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProdutcs;

  List<Product> get products => [..._products];
  List<Product> get favoriteProducts =>
      _products.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  // if (_showFavoriteOnly) {
  //   return _products.where((product) => product.isFavorite).toList();
  // }

  //   return [..._products];
  // }

  // bool _showFavoriteOnly = false;
  // void toggleShowFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void toggleShowAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
}
