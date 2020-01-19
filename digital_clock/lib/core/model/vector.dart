import 'dart:math';

import 'package:digital_clock/core/model/ant.dart';

class Vector {
  final double x;
  final double y;

  const Vector(this.x, this.y);

  operator +(v) => new Vector(x + v.x, y + v.y);
  operator -(v) => new Vector(x - v.x, y - v.y);
  operator /(num v) => new Vector(x / v, y / v);

  bool isEqual(Vector v) => ((x == v.x) && (y == v.y));

  Vector get getCopy {
    return Vector(this.x, this.y);
  }

  double distance(Vector b) {
    return sqrt(pow((b.x - x), 2) + pow((b.y - y), 2));
  }

  double angleRad(Vector b) {
    double aim = atan((b.y - y) / (b.x - x)) -
        1.5708; // because our image initially vertically positioned
    return aim;
  }

  @override
  String toString() {
    return 'x = $x, y = $y';
  }
}
