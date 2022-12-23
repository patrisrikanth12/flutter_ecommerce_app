import 'package:ecommerce_app/screens/product_detail_screen.dart';
import '../provider/product.dart';
import '../provider/cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<CartProvider>(context, listen: false );

    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            product.isFavourite ? Icons.favorite : Icons.favorite_outline,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            product.toggleFavourite();
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            cart.addItem(
              productId: product.id,
              title: product.title,
              price: product.price,
            );
          },
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
