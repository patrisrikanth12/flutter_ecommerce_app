import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/orders_provider.dart';
import 'package:ecommerce_app/widgets/cart_list_item.dart';
import 'package:ecommerce_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = 'cart-screen';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 5.0,
            child: Row(
              children: [
                Text("Total "),
                Spacer(),
                Chip(
                  label: Text("\$${cart.totalPrice}"),
                ),
                TextButton(
                  child: Text("Order Now"),
                  onPressed: () {
                    orders.addOrder(
                      cart.items.values.toList(),
                      cart.totalPrice,
                    );

                    cart.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, index) => CartListItem(
                productId: cart.items.keys.toList()[index],
                id: cart.items.values.toList()[index].id,
                title: cart.items.values.toList()[index].title,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
