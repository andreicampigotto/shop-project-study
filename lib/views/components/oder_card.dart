import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/oder.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('\$ ${order.total.toStringAsFixed(2)}'),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(order.date),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
