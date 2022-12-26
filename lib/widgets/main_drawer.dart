import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/orders_screen.dart';
import 'package:ecommerce_app/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
          child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                "Hello User!",
              ),
            ),
            ListTile(
              title: const Text("Products"),
              trailing: const Icon(Icons.arrow_right),
              onTap: (() {
                Navigator.of(context)
                    .pushNamed(ProductsOverviewScreen.routeName);
              }),
            ),
            ListTile(
              title: const Text("Cart"),
              trailing: const Icon(Icons.arrow_right),
              onTap: (() {
                Navigator.of(context)
                    .pushNamed(CartScreen.routeName);
              }),
            ),
            ListTile(
              title: const Text("Orders"),
              trailing: const Icon(Icons.arrow_right),
              onTap: (() {
                Navigator.of(context)
                    .pushNamed(OrdersScreen.routeName);
              }),
            ),
          ],
              ),
        ),
    );
  }
}
