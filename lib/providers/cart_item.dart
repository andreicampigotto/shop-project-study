class CartItem {
  String? id, productId, description;
  double price;
  int quantity;
  String name;

  CartItem({
    required this.id,
    required this.productId,
    this.description,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
