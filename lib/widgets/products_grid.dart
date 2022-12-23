import 'package:flutter/material.dart';
import './product_item.dart';

import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourites;

  ProductsGrid({required this.showFavourites});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = showFavourites ? productsProvider.favItems 
                                    : productsProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: products[i],
          child: ProductItem(),
        );
      },
    );
  }
}
