import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/order_list.dart';
import 'package:shop/views/orders/oder_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrderList>(context, listen: false).loadOrders(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(child: Text('Something is wrong'));
        } else {
          return Consumer<OrderList>(
            builder: (context, orders, child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (context, i) =>
                    OrderCard(order: orders.orderList[i])),
          );
        }
      }),
    );
  }
}
