import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/products_provider.dart';
import '../widgets/user_products_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = 'user-products-screen';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return UserProductsItem(
            title: products[index].title,
            imageUrl: products[index].imageUrl,
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
