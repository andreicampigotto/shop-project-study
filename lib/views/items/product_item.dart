import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/views/items/product_detail.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline, color: Colors.deepOrange),
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ProductDetail(product: product)));
          },
        ),
      ),
    );
  }
}
