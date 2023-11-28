import 'package:flutter/material.dart';


class ScreenSize {
  BuildContext context;
  ScreenSize(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

 const double paddingSize = 16;

class ConstantSize {
  static const EdgeInsets screenPadding =
      EdgeInsets.only(left: paddingSize, right: paddingSize);
  static const double textFieldHeight = 40.0;
}

const gapW4 = SizedBox(width: 4);
const gapW8 = SizedBox(width: 8);
const gapW12 = SizedBox(width: 12);
const gapW16 = SizedBox(width: 16);
const gapW20 = SizedBox(width: 20);
const gapW24 = SizedBox(width: 24);
const gapH4 = SizedBox(height: 4);
const gapH8 = SizedBox(height: 8);
const gapH12 = SizedBox(height: 12);
const gapH16 = SizedBox(height: 16);
const gapH20 = SizedBox(height: 20);
const gapH24 = SizedBox(height: 24);


