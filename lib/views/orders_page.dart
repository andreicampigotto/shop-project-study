import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/order_list.dart';
import 'package:shop/views/components/app_drawer.dart';
import 'package:shop/views/components/oder_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: const Color.fromARGB(141, 142, 89, 234),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, i) => OrderCard(
                order: orders.orderList[i],
              )),
    );
  }
}
