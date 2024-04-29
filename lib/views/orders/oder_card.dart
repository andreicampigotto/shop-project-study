import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../models/oder.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  const OrderCard({required this.order, super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final itemHeight = (widget.order.products.length * 25) + 8;
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: _expanded ? itemHeight + 88 : 88,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('\$ ${widget.order.total.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: _expanded ? itemHeight.toDouble() : 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              child: ListView(
                children: widget.order.products.map(
                  (product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.quantity}X  \$ ${product.price}',
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 132, 125, 125),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
