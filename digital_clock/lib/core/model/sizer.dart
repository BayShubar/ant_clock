// inspired by ScreenUtill pub

import 'package:digital_clock/config.dart';
import 'package:flutter/material.dart';

class Sizer {
  static Sizer instance = new Sizer();

  final double w = DEVICE_WIDTH;
  final double h = DEVICE_HEIGHT;

  static double _ratio = 5 / 3;
  static double _actualHeight;
  static double _actualWidth;

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    // as we know ratio is 5/3 width = 5 height = 3
    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;
    if (width / height > _ratio) {
      _actualHeight = height;
      _actualWidth = _ratio * height;
    } else {
      _actualWidth = width;
      _actualHeight = width * 1 / _ratio;
    }
  }

  double get scaleWidth => _actualWidth / w;
  double get scaleHeight => _actualHeight / h;
  double getWidth(double width) => width * scaleWidth;
  double getHeight(double height) => height * scaleHeight;
  double getFont(double size) => size * scaleWidth;
}
