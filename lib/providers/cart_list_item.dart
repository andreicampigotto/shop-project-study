class CartListItem {
  String? id, productId;
  double price;
  int quantity;
  String name;

  CartListItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });
}