import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/provider/user_provider.dart';

class UserListItem extends StatelessWidget {

  const UserListItem({super.key, required this.name, required this.mobileNo, required this.address,required this.userId});

  final String? name;
  final String? mobileNo;
  final String? address;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 3,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : $name",
                  style: AppTextStyle.content,
                ),
                Text(
                  "Whats App No : $mobileNo",
                  style: AppTextStyle.content,
                ),
                Text(
                  "Address : $address",
                  style: AppTextStyle.content,
                )
              ],
            ),
            InkWell(
              onTap: (){
                Provider.of<UserProvider>(context, listen: false).deleteUser(userId.toString());
              },
              child:const Icon(Icons.delete,color: red33,)
            )
          ],
        ),
      ),
    );
  }
}
