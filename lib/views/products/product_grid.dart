import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/views/products/product_grid_item.dart';

class ProductGrid extends StatefulWidget {
  // bool showFavoriteOnly;
  // ProductGrid(this.showFavoriteOnly, {super.key});
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
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
    final provider = Provider.of<ProductList>(context);
    // final List<Product> loadedProducts =
    // showFavoriteOnly ? provider.favoriteProducts : provider.products;

    final List<Product> loadedProducts = provider.products;
    return _isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[50]!,
            child: GridView.builder(
              padding: const EdgeInsets.all(7),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              },
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(7),
            itemCount: loadedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8),
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: loadedProducts[i],
              child: Card(
                color: const Color.fromARGB(255, 244, 234, 234),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ProductGridItem(),
              ),
            ),
          );
  }
}
