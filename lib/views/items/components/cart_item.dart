import 'package:flutter/material.dart';
import '../../../providers/cart_item_list.dart';

class CartItem extends StatelessWidget {
  final CartItemList cartItemList;
  const CartItem({required this.cartItemList, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: ListTile(
        title: Text(cartItemList.name),
        subtitle:
            Text('Total\$: ${cartItemList.price * cartItemList.quantity}'),
        trailing: Text('${cartItemList.quantity}X ${cartItemList.price}'),
      ),
    );
  }
}
