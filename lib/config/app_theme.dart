import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    textTheme: const TextTheme(),
    primaryColor: AppColors.dark,
    hoverColor: AppColors.beige10,
    splashColor: AppColors.beige10,
    //
    // AppBar Theme
    //
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.beige,
      ),
      centerTitle: false,
      titleTextStyle: AppTextStyle.playfairDisplay22Beige,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    //
    // Scaffold Theme
    //
    scaffoldBackgroundColor: AppColors.dark,
    //
    // ElevatedButton Theme
    //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: AppColors.beige,
        foregroundColor: AppColors.light,
        textStyle: AppTextStyle.arsenal16LightBold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    //
    // OutlinedButton Theme
    //
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(37),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        side: const BorderSide(color: AppColors.beige, width: 2),
        textStyle: AppTextStyle.arsenal14Light,
        foregroundColor: AppColors.light,
        backgroundColor: AppColors.dark,
      ),
    ),
    //
    //  Text Button Theme
    //
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.light,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
    ),
    //
    // Text Selection Theme
    //
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.beige,
      selectionColor: Color.fromARGB(209, 204, 171, 144),
      selectionHandleColor: AppColors.beige,
    ),
    //
    // Text Field Theme
    //
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
      filled: true,
      fillColor: AppColors.beige10,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.beige,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2,
          color: AppColors.beige,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    //
    // Time Picker Theme
    //
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.dark,
      hourMinuteShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        side: BorderSide(color: AppColors.beige, width: 2),
      ),
      dayPeriodBorderSide: const BorderSide(color: AppColors.beige, width: 2),
      dayPeriodColor: AppColors.beige10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        side: BorderSide(color: AppColors.beige, width: 2),
      ),
      dayPeriodTextColor: AppColors.light,
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        side: BorderSide(color: AppColors.beige, width: 2),
      ),
      hourMinuteColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? AppColors.beige
              : AppColors.beige10),
      hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? AppColors.light
              : AppColors.beige),
      dialHandColor: AppColors.beige10,
      dialBackgroundColor: AppColors.beige10,
      hourMinuteTextStyle:
          const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      dayPeriodTextStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      helpTextStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.light),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
      ),
      dialTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? AppColors.beige
              : AppColors.light),
      entryModeIconColor: AppColors.beige,
    ),

    //
    //  Card Theme
    //

    cardTheme: CardTheme(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.beige, width: 2),
      ),
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(secondary: AppColors.beige50)
        .copyWith(background: AppColors.dark),

    // expansionTileTheme: ExpansionTileTheme()
  );
}

// elevatedButton
