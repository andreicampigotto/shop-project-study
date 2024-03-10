import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/views/items/cart_item.dart';

import '../providers/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: const Color.fromARGB(141, 142, 89, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, i) => CartItem(
                  cartItemList: items[i],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(2, 2, 2, 37),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 7, 7, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "\$${cart.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        Provider.of<OrderList>(
                          context,
                          listen: false,
                        ).addOrder(cart);
                        cart.clear();
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
