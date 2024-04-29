import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/views/manage/product_form_item.dart';

class ProductManage extends StatelessWidget {
  const ProductManage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 7),
        itemCount: products.productsCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            ProductItem(product: products.products[i]),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
