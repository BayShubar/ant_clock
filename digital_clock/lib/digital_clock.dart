// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/agent/main_agent.dart';
import 'package:digital_clock/core/model/sizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  final MainAgent _mainAgent = MainAgent();
  ClockModel get _model => widget.model;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    Future.delayed(Duration(milliseconds: 1000), () {
      _updateTime();
      _updateModel();
    });
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    // setState(() {
    //   // Cause the clock to rebuild when the model changes.
    //
    // });
    _mainAgent.changeTimeFormat(_model.is24HourFormat);
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // _timer = Timer(
      //   Duration(minutes: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
      _timer = Timer(
        Duration(seconds: 4) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // --- MAINN LOCGIC ---
      _mainAgent.eachMin(_dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizer.instance = Sizer()..init(context);
    return Container(
      color: Colors.white,
      child: _mainAgent.build(),
    );
  }
}
