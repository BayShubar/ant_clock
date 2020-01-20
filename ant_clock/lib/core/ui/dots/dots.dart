import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/model/sizer.dart';
import 'package:flutter/material.dart';

class Dots extends StatefulWidget {
  const Dots({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DotsState();
  }
}

class DotsState extends State<Dots> {
  static Color color = Colors.red;
  static double size = 30;
  bool _isVisible = true;

  void blick() {
    setState(() {
      _isVisible = false;
    });
    Future.delayed(
        Duration(milliseconds: 100),
        () => setState(() {
              _isVisible = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: Sizer().getHeight(NUMBER_HEIGHT),
        left: Sizer()
            .getWidth(NUMBER_X_START + NUMBER_WIDTH * 2 + NUMBER_MARGIN + 30),
        child: Visibility(
          visible: _isVisible,
          child: Container(
            height: Sizer().getHeight(ANT_HEIGHT * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[_buildDot, _buildDot],
            ),
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
