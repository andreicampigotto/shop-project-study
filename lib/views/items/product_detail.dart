import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
        ),
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
