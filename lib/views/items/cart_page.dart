import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(17),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total: ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Chip(
                    shape: const StadiumBorder(
                      side: BorderSide(style: BorderStyle.none),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    label: const Text("\$100"),
                    labelStyle: TextStyle(
                      color: Theme.of(context)
                          .primaryTextTheme
                          .headlineMedium
                          ?.color,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    child: const Text('Checkout'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
