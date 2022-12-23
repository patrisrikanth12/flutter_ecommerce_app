import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartListItem({
    required this.productId,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 12.0,
        ),
        padding: EdgeInsets.all(16.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 30.0,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        child: ListTile(
          leading: Text("\$${price}"),
          title: Text(title),
          subtitle: Text("total: ${price * quantity}"),
          trailing: Text("${quantity}x"),
          contentPadding: const EdgeInsets.all(5.0),
        ),
      ),
      onDismissed: (DismissDirection directon) {
        cart.removeItem(productId);
      },
    );
  }
}
