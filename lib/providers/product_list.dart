import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _products = dummyProdutcs;

  List<Product> get products => [..._products];

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
