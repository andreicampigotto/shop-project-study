import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/oder.dart';
import '../models/cart.dart';

class OrderList with ChangeNotifier {
  final List<Order> _orderList = [];

  List<Order> get orderList {
    return [..._orderList];
  }

  int get itemsCount {
    return _orderList.length;
  }

  void addOrder(Cart cart) {
    _orderList.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalPrice,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
