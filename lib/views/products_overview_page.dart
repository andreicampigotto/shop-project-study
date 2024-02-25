import 'package:flutter/material.dart';
import 'package:shop/views/items/components/product_grid.dart';
// import 'package:shop/data/dummy_data.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My store',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Favorite'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('All'),
              ),
            ],
          ),
        ],
      ),
      body: const PrductGrid(),
    );
  }
}
