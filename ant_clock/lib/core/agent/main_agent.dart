import 'dart:async';

import 'package:digital_clock/core/model/sizer.dart';
import 'package:flutter/material.dart';
import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/agent/number_agent.dart';
import 'package:intl/intl.dart';

abstract class Agent {
  Widget build();
}

/// This class controlall ants ant give them number to represent
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
    number1.numberToDisplay(par1);
    number2.numberToDisplay(par2);
    number3.numberToDisplay(par3);
    number4.numberToDisplay(par4);
  }

  void changeTimeFormat(bool is24HourFormat) {
    _is24HourFormat = is24HourFormat;
    eachMin(_lastTime);
  }

  String _getHour(DateTime dateTime) {
    // return DateFormat('ss').format(dateTime);
    if (_is24HourFormat) return DateFormat('HH').format(dateTime);
    return DateFormat('hh').format(dateTime);
  }

  Widget build() {
    return Stack(
      children: <Widget>[
        number1.build(),
        number2.build(),
        number3.build(),
        number4.build(),
      ],
    );
  }
}
