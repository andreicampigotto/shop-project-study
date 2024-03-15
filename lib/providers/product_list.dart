import 'dart:math';

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

  void updateProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  int get producstCount {
    return _products.length;
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
