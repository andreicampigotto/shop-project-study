import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_list.dart';
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
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My store',
        ),
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
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
            onSelected: (FilterOptions selected) {
              if (selected == FilterOptions.favorite) {
                provider.toggleShowFavoriteOnly();
              } else {
                provider.toggleShowAll();
              }
            },
          )
        ],
      ),
      body: const PrductGrid(),
    );
  }
}
