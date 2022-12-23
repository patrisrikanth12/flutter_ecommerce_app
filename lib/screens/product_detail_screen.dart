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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300.0,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "\$${product.price}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
