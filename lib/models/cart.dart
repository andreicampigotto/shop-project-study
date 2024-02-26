import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  // void addItem(String id, CartItem item) {
  //   _items[id] = item;
  //   notifyListeners();
  // }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          price: product.price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  bool isCartEmpty() {
    return _items.isEmpty;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    // _items = {};
    _items.clear();
    notifyListeners();
  }
}
