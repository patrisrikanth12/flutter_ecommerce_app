import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/badge.dart';

import '../widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ShowProducts {
  All,
  Favourites,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = "products-overview-screen";

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          Consumer<CartProvider>(
            builder: (ctx, cart, child) => Badge(
              child: child!,
              value: cart.itemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(onSelected: (ShowProducts selectedValue) {
            setState(() {
              if (selectedValue == ShowProducts.All) {
                _showFavourites = false;
              } else if (selectedValue == ShowProducts.Favourites) {
                _showFavourites = true;
              }
            });
          }, itemBuilder: (ctx) {
            return [
              const PopupMenuItem(
                child: Text("Show All"),
                value: ShowProducts.All,
              ),
              const PopupMenuItem(
                child: Text("Favourites"),
                value: ShowProducts.Favourites,
              ),
            ];
          })
        ],
      ),
      body: ProductsGrid(showFavourites: _showFavourites),
    );
  }
}
