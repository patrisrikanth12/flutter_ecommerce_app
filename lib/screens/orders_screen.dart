import 'package:ecommerce_app/provider/orders_provider.dart';
import 'package:ecommerce_app/widgets/main_drawer.dart';
import 'package:ecommerce_app/widgets/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = 'orders-screen';

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context).items;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext ctx, int index) {
              return OrderListItem(orders[index]);
            }));
  }
}
