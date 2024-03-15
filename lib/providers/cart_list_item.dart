class CartListItem {
  String? imageUrl;
  double price;
  int quantity;
  String id, name, productId;

  CartListItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
}
