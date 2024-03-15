import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/views/components/app_drawer.dart';
import 'package:shop/views/items/product_item.dart';

class ProductManage extends StatelessWidget {
  const ProductManage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 7),
        itemCount: products.producstCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            ProductItem(
              product: products.products[i],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
