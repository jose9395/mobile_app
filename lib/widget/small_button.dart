import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';


class SmallRedElevationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color color;

  const SmallRedElevationButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.03,
        horizontal: width * 0.02,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 3,
          shadowColor: white238,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.content,
        ),
        onPressed: () => onPress(),
      ),
    );
  }
}
