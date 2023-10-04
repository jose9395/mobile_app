import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';

class UserListItem extends StatelessWidget {

  const UserListItem({super.key, required this.name, required this.mobileNo, required this.address,required this.tradeName,required this.gstno,required this.whatsappno});

  final String? name;
  final String? mobileNo;
  final String? address;
  final String? tradeName;
  final String? whatsappno;
  final String? gstno;


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
                    "Whats App No : $whatsappno",
                    style: AppTextStyle.content,
                  ),
                  Text(
                    "Address : $address",
                    style: AppTextStyle.content,
                  ),
                  Text(
                    "Mobile number : $num",
                    style: AppTextStyle.content,
                  ),
                  Text(
                    "GST number : $gstno",
                    style: AppTextStyle.content,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
