class CartListItem {
  String? id, productId, imageUrl;
  double price;
  int quantity;
  String name;

  CartListItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
}
