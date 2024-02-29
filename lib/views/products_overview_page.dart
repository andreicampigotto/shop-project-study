import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/views/items/components/product_grid.dart';
// import 'package:shop/data/dummy_data.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My store',
        ),
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              padding: const EdgeInsets.all(2),
              textColor: Colors.white,
              backgroundColor: Colors.red,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_checkout),
                onPressed: () {
                  cart.itemsCount;
                },
              ),
            ),
          ),
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
              setState(
                () {
                  if (selected == FilterOptions.favorite) {
                    _showFavoriteOnly = true;
                  } else {
                    _showFavoriteOnly = false;
                  }
                },
              );
              //   if (selected == FilterOptions.favorite) {
              //     // provider.toggleShowFavoriteOnly();
              //   } else {
              //     // provider.toggleShowAll();
              //   }
            },
          ),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
