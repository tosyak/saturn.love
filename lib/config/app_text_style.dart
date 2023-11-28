import 'package:saturn/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();

  static const arsenal = 'Arsenal';
  static const playfairDisplay = 'PlayfairDisplay';
}

abstract class AppTextStyle {
  static const playfairDisplay22Beige = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.playfairDisplay,
    height: 24 / 22,
    color: AppColors.beige,
    letterSpacing: 0.5,
  );

  static const playfairDisplay19Beige = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.playfairDisplay,
    height: 35 / 26,
    color: AppColors.beige,
    letterSpacing: 0.5,
  );

  static const arsenal10Light = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 13 / 10,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal12Light = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 15 / 12,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal12LightBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 15 / 12,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal14Light = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 18 / 14,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal14LightBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 18 / 14,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal16Light = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 20 / 16,
    color: AppColors.light,
    letterSpacing: 0.5,
  );
  static const arsenal16LightBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 20 / 16,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal16BeigeBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 20 / 16,
    color: AppColors.beige,
    letterSpacing: 0.5,
  );

  static const arsenal20Light = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 25 / 20,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal20LightBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 28 / 22,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal22Light = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 28 / 22,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal22LightBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 28 / 22,
    color: AppColors.light,
    letterSpacing: 0.5,
  );

  static const arsenal22BeigeBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 28 / 22,
    color: AppColors.beige,
    letterSpacing: 0.5,
  );

  static const arsenal24LightBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.arsenal,
    height: 30 / 24,
    color: AppColors.light,
    letterSpacing: 0.5,
  );
}
