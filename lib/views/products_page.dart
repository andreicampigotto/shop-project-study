import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/product_list.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then(
          (value) => setState(() {
            _isLoading = false;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My store',
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(
                Icons.shopping_basket_sharp,
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.CART);
                setState(() {});
              },
            ),
            builder: (context, cart, child) => Badge.count(
              padding: const EdgeInsets.all(2),
              largeSize: 20,
              textStyle:
                  TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
              count: cart.itemsCount,
              child: child,
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 8),
              child: ProductGrid(
                _showFavoriteOnly,
              ),
            ),
      drawer: const AppDrawer(),
    );
  }
}
