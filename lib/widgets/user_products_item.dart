import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProductsItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductsItem({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      title: Text(title),
      trailing: Container(
        // row and trailing takes as much as space possible.
        // so we wrapped row in a container
        width: 100.0,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
