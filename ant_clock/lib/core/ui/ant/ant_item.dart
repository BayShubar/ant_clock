import 'dart:math' as MATH;

import 'package:digital_clock/core/model/path.dart';
import 'package:digital_clock/core/model/sizer.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/model/ant.dart';

class AntItem extends StatefulWidget {
  final AntData antData;

  const AntItem({Key key, @required this.antData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AntItemState();
  }
}

class AntItemState extends State<AntItem> with TickerProviderStateMixin {
  /// -----------------------------------------------
  /// DECLEARATION
  /// -----------------------------------------------
  Animation _animation;
  AnimationController _animationController;
  Animation _angleAnimation;
  AnimationController _angleController;

  bool _isAnimating = false;
  bool _isTurnAnimating = false;

  AntPosition _initial; // This is used to animation porposes
  AntPosition _final; // This is used to animation porposes

  PathExecutor _pathExecutor;

  AntPosition get _hidden => widget.antData.initialPosition
      .getCopy; // This position where our ant will be hiden
  AntPosition get _showing => widget
      .antData.finalPoisition.getCopy; // This poistion where ant show time

  @override
  void initState() {
    _pathExecutor = PathExecutor(
      pathGenerator: PathGenerator(widget.antData),
      moveTo: _moveTo,
      turnTo: _turnTo,
    );
    setState(() {
      // We set each ant to its initial poisitions
      _initial = _hidden;
      _final = _hidden;
    });

    // Movement controller
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANT_MOVEMENT_TIME));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();

        /// When ant stande to destination
        setState(() {
          _initial =
              AntPosition(vector: _final.vector.getCopy, angle: _initial.angle);
          _isAnimating = false;
        });
      }
    });

    // Angle Controller
    _angleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANT_ANGLE_TIME));
    _angleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_angleController);

    _angleAnimation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _angleController.reset();
        setState(() {
          _initial =
              AntPosition(vector: _initial.vector.getCopy, angle: _final.angle);
          _isTurnAnimating = false;
        });

        /// When ant stande to destination
      }
    });

    super.initState();
  }

  /// -----------------------------------------------
  /// PRIVATE
  /// -----------------------------------------------

  _moveTo(AntPosition position) {
    setState(() {
      _final = position;
      _isAnimating = true;
    });
    _animationController.forward();
  }

  _turnTo(double angle) {
    setState(() {
      _final = AntPosition(vector: _final.vector.getCopy, angle: angle);
      _isTurnAnimating = true;
    });
    _angleController.forward();
  }

  bool get _isMoving => _isAnimating || _isTurnAnimating;

  /// -----------------------------------------------
  /// PUBLIC
  /// -----------------------------------------------

  // With this we can cantrol each item
  void show() {
    if (_final.isEqual(_showing)) {
      // This mean that ant already showing
    } else {
      _pathExecutor.show();
    }
  }

  void hide() {
    if (_final.isEqual(_hidden)) {
      // This mean that ant already hiding
    } else {
      _pathExecutor.hide();
    }
  }

  /// -----------------------------------------------
  /// RENDER
  /// -----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return _AnimatedAnt(
      animation: _animation,
      intialPosition: _initial,
      finalPosition: _final,
      child: _AnimatedAntAngle(
        animation: _angleAnimation,
        isAnimating: _isMoving,
        intialPosition: _initial,
        finalPosition: _final,
      ),
    );
  }
}

class _AnimatedAnt extends AnimatedWidget {
  final AntPosition intialPosition;
  final AntPosition finalPosition;
  final Widget child;
  _AnimatedAnt(
      {Key key,
      Animation animation,
      @required this.intialPosition,
      @required this.child,
      @required this.finalPosition})
      : super(key: key, listenable: animation);

  double calcY(double i) {
    double difference = finalPosition.vector.y - intialPosition.vector.y;
    return intialPosition.vector.y + i * difference;
  }

  double calcX(double i) {
    double difference = finalPosition.vector.x - intialPosition.vector.x;
    return intialPosition.vector.x + i * difference;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final double i = animation.value;
    return Positioned(
      top: Sizer().getHeight(calcY(i) - ANT_HEIGHT / 2),
      left: Sizer().getWidth(calcX(i) - ANT_WIDTH / 2),
      child: child,
    );
  }
}

class _AnimatedAntAngle extends AnimatedWidget {
  final AntPosition intialPosition;
  final AntPosition finalPosition;
  final bool isAnimating;
  _AnimatedAntAngle(
      {Key key,
      Animation animation,
      Animation angleAnimation,
      @required this.intialPosition,
      @required this.isAnimating,
      @required this.finalPosition})
      : super(key: key, listenable: animation);

  double angle(double i) {
    double difference = finalPosition.angle - intialPosition.angle;
    // if(difference > MATH.pi){
    //   difference = MATH.pi*2 - difference;
    // }
    return intialPosition.angle + i * difference;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final double i = animation.value;
    // print('---- $isAnimating');
    return Transform.rotate(
      alignment: Alignment.center,
      angle: angle(i),
      // child: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.black,
      //     border: Border(top: BorderSide(color: Colors.red, width: 3))
      //   ),
      //   height: Sizer().getWidth(
      //       ANT_HEIGHT), // because it will work in different direction
      //   width: Sizer().getWidth(ANT_WIDTH),
      // ),
      child: SizedBox(
        height: Sizer().getWidth(ANT_HEIGHT),
        width: Sizer().getWidth(ANT_WIDTH),
        child: FlareActor(
          'assets/ant.flr',
          animation: 'run',
          isPaused: !isAnimating,
        ),
      ),
    );
  }
}
