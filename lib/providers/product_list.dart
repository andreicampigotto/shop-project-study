// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constats.dart';

class ProductList with ChangeNotifier {
  final String _token;
  List<Product> _productsItems = [];

  List<Product> get products => [..._productsItems];
  List<Product> get favoriteProducts =>
      _productsItems.where((product) => product.isFavorite).toList();

  ProductList(this._token, this._productsItems);

  Future<void> loadProducts() async {
    _productsItems.clear();
    final response = await http.get(
      Uri.parse(
        '${Constants.productBaseUrl}.json?auth=$_token',
      ),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _productsItems.add(Product(
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
      Uri.parse(
        '${Constants.productBaseUrl}.json?auth=$_token',
      ),
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
    _productsItems.add(Product(
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
    int index = _productsItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.productBaseUrl}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
            'name': product.name,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
          },
        ),
      );

      _productsItems[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _productsItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _productsItems[index];

      _productsItems.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.productBaseUrl}/${product.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _productsItems.insert(index, product);
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
    return _productsItems.length;
  }

  // if (_showFavoriteOnly) {
  //   return _productsItems.where((product) => product.isFavorite).toList();
  // }

  //   return [..._productsItems];
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
