import '../providers/cart_list_item.dart';

class Order {
  String id;
  double total;
  List<CartListItem> products;
  DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
