import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/routes.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite(auth.idToken ?? '', auth.userId ?? '');
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: const Color.fromARGB(255, 255, 102, 56)),
            ),
          ),
          title: Text(product.name),
          trailing: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Product added successfully!',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                  elevation: 17,
                  // backgroundColor: Theme.of(context).,
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.amberAccent,
            ),
          ),
        ),
        child: Hero(
          tag: product.id,
          child: GestureDetector(
            child: Image.network(product.imageUrl!, fit: BoxFit.cover),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Routes.PRODUCT_DETAIL, arguments: product);
            },
          ),
        ),
      ),
    );
  }
}
