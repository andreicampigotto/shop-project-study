import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/views/products/product_grid.dart';

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
  final bool _showFavoriteOnly = false;
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
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin: const EdgeInsets.only(top: 8),
            child: ProductGrid(
              _showFavoriteOnly,
            ),
          );
  }
}
