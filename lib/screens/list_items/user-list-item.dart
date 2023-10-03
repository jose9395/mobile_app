import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';

class UserListItem extends StatelessWidget {

  const UserListItem({super.key, required this.name, required this.mobileNo, required this.address});

  final String? name;
  final String? mobileNo;
  final String? address;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(3.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
             /*     Provider.of<UserProvider>(context, listen: false).deleteUser(userId.toString());*/
                },
                child: const Icon(Icons.delete_outlined,color: red33,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
