import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/views/items/product_item.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProdutcs;
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
      body: GridView.builder(
          padding: const EdgeInsets.all(7),
          itemCount: loadedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7),
          itemBuilder: (ctx, i) => ProductItem(
                product: loadedProducts[i],
              )),
    );
  }
}
