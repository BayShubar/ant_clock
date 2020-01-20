import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digital_clock/core/model/vector.dart';

class AntPosition {
  final Vector vector;
  final double angle;
  const AntPosition({@required this.vector, @required this.angle});

  AntPosition withOffset(Vector offset) {
    return AntPosition(angle: angle, vector: vector + offset);
  }

  AntPosition get getCopy {
    return AntPosition(angle: angle, vector: vector.getCopy);
  }

  bool isEqual(AntPosition b) {
    if (b.vector.isEqual(vector) && angle == b.angle) return true;
    return false;
  }
}

/// Each ant actually has only 2 position
/// initial - where ant is hiding
/// final - where ant is stand and show own beauty :)
class AntData {
  final AntPosition initialPosition;
  final AntPosition finalPoisition;

  AntData({@required this.initialPosition, @required this.finalPoisition});
}
