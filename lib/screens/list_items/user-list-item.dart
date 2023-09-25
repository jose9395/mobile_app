import 'package:flutter/material.dart';


class UserListItem extends StatelessWidget {
   UserListItem({super.key, required this.name, required this.mobileno});
   final String? name;
   final String? mobileno;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Text(name.toString()),
            Text(mobileno.toString())
          ],
        ),
      ),
    );
  }
}
