import 'package:flutter/material.dart';
import 'package:saturn/config/app_text_style.dart';

const double appBarActionsWidth = 49;
const double appBarLeadingWidth = 31;
const double appBarHorizontalPadding = 32;
const double appBarVerticalPadding = 30;

class AppBarHeightCalc {
  final String title;
  final double width;
  const AppBarHeightCalc({
    required this.title,
    required this.width,
  });

  final style = AppTextStyle.playfairDisplay22Beige;

  double calculateLeadingHeight() {
    TextPainter textPainter = TextPainter()
      ..text = TextSpan(text: title, style: style)
      ..textDirection = TextDirection.ltr
      ..layout(
          minWidth: 0,
          maxWidth: width - appBarLeadingWidth - appBarHorizontalPadding);
    return (textPainter.size.height + appBarVerticalPadding);
  }

  double calculateActionsHeight() {
    TextPainter textPainter = TextPainter()
      ..text = TextSpan(text: title, style: style)
      ..textDirection = TextDirection.ltr
      ..layout(
          minWidth: 0,
          maxWidth: width - appBarActionsWidth - appBarHorizontalPadding);
    return (textPainter.size.height + appBarVerticalPadding);
  }

  double calculateLeadingAndActionsHeight() {
    TextPainter textPainter = TextPainter()
      ..text = TextSpan(text: title, style: style)
      ..textDirection = TextDirection.ltr
      ..layout(
          minWidth: 0,
          maxWidth: width -
              appBarActionsWidth -
              appBarHorizontalPadding -
              appBarLeadingWidth);
    return (textPainter.size.height + appBarVerticalPadding);
  }

  double calculateHeight() {
    TextPainter textPainter = TextPainter()
      ..text = TextSpan(text: title, style: style)
      ..textDirection = TextDirection.ltr
      ..layout(minWidth: 0, maxWidth: width);
    return (textPainter.size.height + appBarVerticalPadding);
  }
}
