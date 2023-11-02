import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class   AppTextStyle {

  static final title = TextStyle(
      fontSize: 22 * SizeConfig.textMultiplier!,
      color: black3E,
      fontFamily: GoogleFonts.raleway.toString(),
      fontWeight: FontWeight.w500);

  static final sub_title = TextStyle(
      fontSize: 18 * SizeConfig.textMultiplier!,
      color: black3E,
      fontFamily: GoogleFonts.raleway.toString(),
      fontWeight: FontWeight.w300);

  static final content = TextStyle(
      fontSize: 15 * SizeConfig.textMultiplier!,
      color: grey62,
      fontFamily: GoogleFonts.raleway.toString());

  //white text
  static final content_white = TextStyle(
      fontSize: 15 * SizeConfig.textMultiplier!,
      color: white,
      fontFamily: GoogleFonts.raleway.toString());

  static final sub_title_white = TextStyle(
      fontSize: 18 * SizeConfig.textMultiplier!,
      color: white,
      fontFamily: GoogleFonts.raleway.toString(),
      fontWeight: FontWeight.w300);
}