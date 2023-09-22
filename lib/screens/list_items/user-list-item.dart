import 'package:flutter/material.dart';


class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Text("Name")
          ],
        ),
      ),
    );
  }
}
