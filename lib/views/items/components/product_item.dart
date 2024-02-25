import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: true,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            onPressed: () {
              product.toggleFavorite();
            },
            icon: Icon(
                product.favorite ? Icons.favorite : Icons.favorite_outline,
                color: Colors.deepOrange),
          ),
          title: Text(product.title),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined,
                color: Colors.lightBlue),
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.PRODUCT_DETAIL, arguments: product);
          },
        ),
      ),
    );
  }
}
