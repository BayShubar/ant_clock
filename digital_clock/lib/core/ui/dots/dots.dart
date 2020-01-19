import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/model/sizer.dart';
import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  static Color color = Colors.white;
  static double size = 30;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: Sizer().getHeight(NUMBER_HEIGHT),
        left: Sizer()
            .getWidth(NUMBER_X_START + NUMBER_WIDTH * 2 + NUMBER_MARGIN + 30),
        child: Container(
          height: Sizer().getHeight(ANT_HEIGHT * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[_buildDot, _buildDot],
          ),
        ));
  }

  Widget get _buildDot => Container(
        width: Sizer().getWidth(size),
        height: Sizer().getWidth(size),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(size)),
      );
}
