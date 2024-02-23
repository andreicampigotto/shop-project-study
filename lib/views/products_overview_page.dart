import 'package:flutter/material.dart';
import 'package:shop/views/items/components/product_grid.dart';
// import 'package:shop/data/dummy_data.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My store',
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: PrductGrid(),
    );
  }
}
