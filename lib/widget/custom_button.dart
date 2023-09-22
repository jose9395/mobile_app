import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
        this.buttonColor = green33,
        this.borderRadius = 4,
        this.width,
        this.splashColor = green32,
        required this.text,
        this.onPressed,
        this.textStyle})
      : super(key: key);
  final Color buttonColor;
  final double borderRadius;
  final double? width;
  final Color splashColor;
  final String text;
  final TextStyle? textStyle;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                animationDuration: const Duration(milliseconds: 300),
                primary: splashColor,
                textStyle: textStyle ??
                    AppTextStyle.content.copyWith(
                      fontSize: 12 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w700,
                      color: black3E,
                    ),
                backgroundColor: buttonColor,
                fixedSize: Size(
                  width ?? double.infinity,
                  48 * SizeConfig.heightMultiplier!,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius))),
            child: Text(
              text.toUpperCase(),
              style: textStyle ??
                  AppTextStyle.content.copyWith(
                    fontSize: 12 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.w700,
                    color: white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
