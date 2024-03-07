import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import '../../../providers/cart_list_item.dart';

class CartItem extends StatelessWidget {
  final CartListItem cartItemList;
  const CartItem({required this.cartItemList, super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemList.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: const Color.fromARGB(234, 255, 0, 0),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 27),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItemList.productId!);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 7,
        ),
        elevation: 7,
        child: ListTile(
          leading: SizedBox.square(
            dimension: 92,
            child: Image.network(
              cartItemList.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(cartItemList.name),
          subtitle:
              Text('Total\$: ${cartItemList.price * cartItemList.quantity}'),
          trailing: Text(
            '${cartItemList.quantity}X ${cartItemList.price}',
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
