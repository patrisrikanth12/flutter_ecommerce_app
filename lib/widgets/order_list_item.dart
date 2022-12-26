import 'package:ecommerce_app/provider/orders_provider.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem order;
  OrderListItem(this.order);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
            ),
            title: Text(
              widget.order.total.toString(),
            ),
            subtitle: Text(
              widget.order.time.toString(),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: isExpanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
            ),
          ),
          if (isExpanded)
            (Column(
              children: [
                const Divider(thickness: 1.0),
                ...widget.order.products.map((product) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(product.title),
                  );
                }).toList(),
              ],
            )),
        ],
      ),
    );
  }
}
