class Product {
  String? id, description, imageUrl;
  double price;
  bool favorite;
  String title;

  Product({
    this.id,
    required this.title,
    this.imageUrl,
    this.description,
    this.price = 0.00,
    this.favorite = false,
  });

  void toggleFavorite() {
    favorite = !favorite;
  }

  // Product.fromJson(Map<String, dynamic> json) {
  //   id = json['full_name'];
  //   user = json['owner']['login'];
  //   avatar = json['owner']['avatar_url'];
  //   description = json['description'];
  // }
}
