import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import '../provider/product.dart';

import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "product-detail-screen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    final Product product =
        Provider.of<ProductsProvider>(context, listen: false)
            .getProductbyId(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
