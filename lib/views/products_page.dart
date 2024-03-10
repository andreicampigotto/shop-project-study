import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/views/components/app_drawer.dart';
import 'package:shop/views/components/product_grid.dart';
// import 'package:shop/data/dummy_data.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My store',
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(141, 142, 89, 234),
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_checkout_rounded, size: 27),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.CART);
                setState(() {});
              },
            ),
            builder: (context, cart, child) => Badge(
              padding: const EdgeInsets.all(2),
              backgroundColor: const Color.fromARGB(255, 228, 82, 29),
              textStyle: const TextStyle(fontSize: 12, color: Colors.white),
              child: child,
              // label: child,
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
      body: ProductGrid(
        _showFavoriteOnly,
      ),
      drawer: AppDrawer(),
    );
  }
}
