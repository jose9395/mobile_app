

import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';

snackBarSuccessWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: green33,
      content: Text(
        text,
        style:AppTextStyle.content,
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

snackBarErrorWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 5,
      backgroundColor: red33,
      content: Text(
        text,
        style: AppTextStyle.content,
      ),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
