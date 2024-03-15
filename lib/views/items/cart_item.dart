import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import '../../providers/cart_list_item.dart';

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
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?', style: TextStyle(fontSize: 24)),
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
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItemList.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 7,
        ),
        elevation: 7,
        child: ListTile(
          leading: Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
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
