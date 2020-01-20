import 'dart:math';

import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/model/ant.dart';
import 'package:digital_clock/core/model/vector.dart';
import 'package:flutter/material.dart';

/// Each Ant will be given
/// path to move for instance
class Path {
  final double initialAngle;

  final Vector destination;
  final double finalAngle;

  Path(
      {@required this.initialAngle,
      @required this.destination,
      this.finalAngle = null});

  bool get isFinal => this.finalAngle != null;
}

/// This will generate random path
/// to ant between two points
/// Actually Here I need write some more
/// code to make it more close to ant path
class PathGenerator {
  final AntData antData;

  const PathGenerator(this.antData);

  List<Path> show() {
    if (Random().nextBool()) return _withMiddlePath();
    return _directPath();
  }

  List<Path> _withMiddlePath() {
    Vector middle = generatePoint(
        antData.initialPosition.vector, antData.finalPoisition.vector);
    return [
      Path(
          initialAngle: middle.angleRad(antData.finalPoisition.vector),
          destination: antData.finalPoisition.vector,
          finalAngle: antData.finalPoisition.angle),
      Path(
          initialAngle: antData.initialPosition.vector.angleRad(middle),
          destination: middle),
    ];
  }

  List<Path> _directPath() {
    return [
      Path(
          initialAngle: antData.initialPosition.vector
              .angleRad(antData.finalPoisition.vector),
          destination: antData.finalPoisition.vector,
          finalAngle: antData.finalPoisition.angle),
    ];
  }

  List<Path> hide() {
    return [
      Path(
          initialAngle: antData.finalPoisition.vector
              .angleRad(antData.initialPosition.vector),
          destination: antData.initialPosition.vector,
          finalAngle: antData.initialPosition.angle),
    ];
  }

  Vector generatePoint(Vector a, Vector b) {
    // return Vector(300, 300);
    Vector delta = b - a;
    Vector center = a + delta / 2;
    double ran = Random().nextDouble() * 300;
    return Vector(center.x + 100 + ran, center.y - 100 + ran);
  }
}

class QueueItem {
  final int duration;
  final void Function() execute;

  QueueItem({@required this.duration, @required this.execute});
}

/// In order to reach destinnation ant move some sophisticated path
/// or in other word path between A and B may consist multiple small pathes
/// to and this will execute each path step by step
class PathExecutor {
  final PathGenerator pathGenerator;
  final void Function(AntPosition position) moveTo;
  final void Function(double angle) turnTo;

  List<QueueItem> _queue = [];
  bool isWorking = false;

  PathExecutor(
      {@required this.pathGenerator,
      @required this.moveTo,
      @required this.turnTo});

  void show() {
    _queue = _pathToQueue(pathGenerator.show());
    _worker();
  }

  void hide() {
    _queue = _pathToQueue(pathGenerator.hide());
    _worker();
  }

  List<QueueItem> _pathToQueue(List<Path> paths) {
    List<QueueItem> items = [];
    for (Path path in paths) {
      if (path.isFinal) {
        items.add(QueueItem(
            duration: ANT_ANGLE_TIME,
            execute: () {
              turnTo(path.finalAngle);
            }));
      }
      items.add(QueueItem(
          duration: ANT_MOVEMENT_TIME,
          execute: () {
            moveTo(AntPosition(
                angle: path.initialAngle, vector: path.destination));
          }));
      items.add(QueueItem(
          duration: ANT_ANGLE_TIME,
          execute: () {
            turnTo(path.initialAngle);
          }));
    }
    return items;
  }

  void _worker() async {
    if (isWorking || _queue.length == 0) return;
    isWorking = true;
    while (_queue.length != 0) {
      QueueItem item = _queue.last;
      // _dispatch(ServerAziEvent(instruction: item.getInstructon));
      item.execute();
      _queue.removeAt(_queue.length - 1);
      await Future.delayed(Duration(milliseconds: item.duration));
    }
    isWorking = false;
  }
}
