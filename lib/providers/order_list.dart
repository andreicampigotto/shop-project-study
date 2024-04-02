import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop/utils/constats.dart';
import '../models/cart.dart';
import '../models/oder.dart';
import './cart_list_item.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final List<Order> _orderList = [];

  List<Order> get orderList {
    return [..._orderList];
  }

  int get itemsCount {
    return _orderList.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}.json'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'products': cart.items.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'price': cartItem.price,
                  'quantity': cartItem.quantity,
                  'imageUrl': cartItem.imageUrl,
                },
              )
              .toList(),
          'date': date.toIso8601String(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _orderList.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    _orderList.clear();

    final response = await http.get(
      Uri.parse('${Constants.orderBaseUrl}.json'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      _orderList.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartListItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }
}
