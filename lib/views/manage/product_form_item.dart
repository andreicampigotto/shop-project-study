import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_list.dart';
import '../../utils/routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final message = ScaffoldMessenger.of(context);
    return ListTile(
      leading: Container(
        height: 82,
        width: 82,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        child: Image.network(
          product.imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.edit,
                  // color: Theme.of(context).primaryColor
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Routes.PRODUCT_FORM,
                    arguments: product,
                  );
                }),
            IconButton(
              icon: const Icon(Icons.delete),
              color: const Color.fromARGB(234, 255, 0, 0),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure?',
                        style: TextStyle(fontSize: 24)),
                    content: const Text(
                      'If you click yes, you will remove the item!',
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ).then(
                  (value) async {
                    if (value ?? false) {
                      try {
                        await Provider.of<ProductList>(
                          context,
                          listen: false,
                        ).removeProduct(product);
                      } on HttpException catch (error) {
                        message.showSnackBar(
                          SnackBar(
                            content: Text(
                              error.toString(),
                            ),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
