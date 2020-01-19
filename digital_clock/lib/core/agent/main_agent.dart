import 'dart:async';

import 'package:digital_clock/core/model/sizer.dart';
import 'package:flutter/material.dart';
import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/agent/number_agent.dart';
import 'package:intl/intl.dart';

abstract class Agent {
  Widget build();
}

class MainAgent extends Agent {
  final NumberAgent number1 = NumberAgent(NUMBER_1);
  final NumberAgent number2 = NumberAgent(NUMBER_2);
  final NumberAgent number3 = NumberAgent(NUMBER_3);
  final NumberAgent number4 = NumberAgent(NUMBER_4);
  // STATE MANNAGEMENT
  bool _is24HourFormat = true;
  DateTime _lastTime = DateTime.now();

  void eachMin(DateTime dateTime) {
    _lastTime = dateTime;
    final String hour = _getHour(dateTime);
    final String minute = DateFormat('mm').format(dateTime);
    int par1 = int.parse(hour.substring(0, 1));
    int par2 = int.parse(hour.substring(1, 2));
    int par3 = int.parse(minute.substring(0, 1));
    int par4 = int.parse(minute.substring(1, 2));
    number1.numberToDisplay(par1 % 2);
    number2.numberToDisplay(par2);
    number3.numberToDisplay(par3);
    number4.numberToDisplay(par4);
  }

  void changeTimeFormat(bool is24HourFormat) {
    _is24HourFormat = is24HourFormat;
    eachMin(_lastTime);
  }

  String _getHour(DateTime dateTime) {
    if (_is24HourFormat) return DateFormat('HH').format(dateTime);
    return DateFormat('hh').format(dateTime);
  }

  Widget get _buildDots => Positioned(
      top: Sizer().getHeight(NUMBER_HEIGHT),
      left: Sizer()
          .getWidth(NUMBER_X_START + NUMBER_WIDTH * 2 + NUMBER_MARGIN + 30),
      child: Container(
        height: Sizer().getHeight(ANT_HEIGHT * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: Sizer().getWidth(40),
              height: Sizer().getWidth(40),
              color: Colors.red,
            ),
            Container(
              width: Sizer().getWidth(40),
              height: Sizer().getWidth(40),
              color: Colors.red,
            )
          ],
        ),
      ));

  Widget build() {
    return Stack(
      children: <Widget>[
        _buildDots,
        number1.build(),
        number2.build(),
        number3.build(),
        number4.build(),
      ],
    );
  }
}
