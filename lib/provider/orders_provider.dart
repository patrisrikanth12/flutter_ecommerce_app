import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';

class OrderItem {
  final String id;
  final double total;
  final DateTime time;
  final List<CartItem> products;

  OrderItem({
    required this.id,
    required this.total,
    required this.time,
    required this.products,
  });
}

class OrdersProvider extends ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> products, double totalPrice) {
    _items.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        total: totalPrice,
        time: DateTime.now(),
        products: products,
      ),
    );

    notifyListeners();
  }
}
