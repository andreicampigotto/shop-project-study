import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constats.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => [..._products];
  List<Product> get favoriteProducts =>
      _products.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    _products.clear();
    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _products.add(Product(
        id: productId,
        name: productData['name'],
        price: productData['price'],
        description: productData['description'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json'),
      body: jsonEncode(
        {
          'name': product.name,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _products.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();

    // .catchError(() {});
  }

  Future<void> updateProduct(Product product) async {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
        body: jsonEncode(
          {
            'name': product.name,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
          },
        ),
      );

      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _products[index];

      _products.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _products.insert(index, product);
        notifyListeners();
        throw HttpException(
          message: 'Deletion error ',
          statusCode: response.statusCode,
        );
      }
    }
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
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
