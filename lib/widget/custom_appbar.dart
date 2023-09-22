


import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';


class MyCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  MyCustomAppbar({Key? key, required this.title,required this.onPressed}) : super(key: key);
  final String title;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80 * SizeConfig.heightMultiplier!,
      backgroundColor: green33,
      elevation: 0.5,
      leading: IconButton(
        onPressed: onPressed,
        icon:const Icon(Icons.arrow_back)
      ),
      title: Text(
        title,
        style: AppTextStyle.sub_title_white.copyWith(
          fontSize: 18 * SizeConfig.textMultiplier!,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80 * SizeConfig.heightMultiplier!);
}
