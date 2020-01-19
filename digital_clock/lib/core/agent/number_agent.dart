import 'dart:math';

import 'package:flutter/material.dart';
import 'package:digital_clock/config.dart';
import 'package:digital_clock/core/agent/main_agent.dart';
import 'package:digital_clock/core/model/ant.dart';
import 'package:digital_clock/core/model/indexed_key.dart';
import 'package:digital_clock/core/model/vector.dart';
import 'package:digital_clock/core/ui/ant/ant_item.dart';
import 'package:digital_clock/core/ui/number/number_controller.dart';

const List<AntPosition> POSITIONS = [
  AntPosition(vector: Vector(ANT_WIDTH / 2, ANT_HEIGHT / 2), angle: 0), // 0
  AntPosition(
      vector: Vector(ANT_WIDTH + ANT_MARGIN + ANT_HEIGHT / 2, ANT_WIDTH / 2),
      angle: 1.57), // 1
  AntPosition(
      vector: Vector(ANT_HEIGHT + ANT_WIDTH + ANT_MARGIN * 2 + ANT_WIDTH / 2,
          ANT_HEIGHT / 2),
      angle: 0), //2
  AntPosition(
      vector: Vector(
          ANT_WIDTH + ANT_MARGIN + ANT_HEIGHT / 2, ANT_HEIGHT - ANT_MARGIN / 2),
      angle: 1.57), // 3
  AntPosition(
      vector: Vector(ANT_WIDTH / 2, ANT_HEIGHT + ANT_MARGIN + ANT_HEIGHT / 2),
      angle: 0), // 4
  AntPosition(
      vector: Vector(ANT_WIDTH + ANT_MARGIN + ANT_HEIGHT / 2,
          ANT_HEIGHT * 2 + ANT_MARGIN - ANT_WIDTH / 2),
      angle: 1.57), // 5
  AntPosition(
      vector: Vector(ANT_HEIGHT + ANT_WIDTH + ANT_MARGIN * 2 + ANT_WIDTH / 2,
          ANT_HEIGHT + ANT_MARGIN + ANT_HEIGHT / 2),
      angle: 0), // 6
];

const List<List<int>> ANTS_TO_NUMBER = [
  [0, 1, 2, 4, 5, 6], //0
  [2, 6], //1
  [1, 2, 3, 4, 5], //2
  [1, 2, 3, 5, 6], //3
  [0, 3, 2, 6], //4
  [1, 0, 3, 6, 5], //5
  [1, 0, 3, 6, 5, 4], //6
  [1, 2, 6], //7
  [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
  ], //8
  [0, 1, 2, 3, 6, 5],
];

class NumberAgent extends Agent {
  // This define initial position of
  // number and ants will be positioned based to this point
  final Vector _initialPoint;
  // This is control controller by state
  final GlobalKey<NumberControllerState> _numberController =
      GlobalKey<NumberControllerState>();

  final GlobalKeyToIdManager<AntItemState, AntData> _ants;

  NumberAgent(Vector initialPoint)
      : _initialPoint = initialPoint,
        _ants = generateAnts(initialPoint);

  // CONNTROLLER

  void numberToDisplay(int number) {
    List<int> responsibleAnts = ANTS_TO_NUMBER[number];
    List<int> unresponsibleAnts = _outBound(responsibleAnts);
    _numberController.currentState.show(responsibleAnts);
    _numberController.currentState.hide(unresponsibleAnts);
  }

  // PRIVATE

  List<int> _outBound(List<int> items) {
    // FOR FUTURE ...
    List<int> result = [];
    List<int> all = [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
    ];
    for (int i in all) {
      bool addble = true;
      for (int j in items) {
        if (i == j) addble = false;
      }
      addble ? result.add(i) : null;
    }
    return result;
  }

  @override
  Widget build() {
    return NumberController(
      key: _numberController,
      ants: _ants,
    );
  }

  static GlobalKeyToIdManager<AntItemState, AntData> generateAnts(
      Vector offset) {
    GlobalKeyToIdManager<AntItemState, AntData> items =
        GlobalKeyToIdManager<AntItemState, AntData>(
            <GlobalKeyToId<AntItemState, AntData>>[]);
    //Distributing final positions to each ant
    int index = 0;
    Random random = Random();
    for (AntPosition finalPosition in POSITIONS) {
      AntPosition intialPosition = AntPosition(
          vector: Vector(
              random.nextInt(10) * 60.0 * (random.nextBool() ? -1 : 1),
              random.nextBool() ? 1000 : -500),
          angle: 0);
      AntPosition finalWithOffset = finalPosition.withOffset(offset);
      AntPosition initialWithOffset = intialPosition.withOffset(offset);
      GlobalKeyToId<AntItemState, AntData> item =
          GlobalKeyToId<AntItemState, AntData>(
              index,
              GlobalKey<AntItemState>(),
              AntData(
                  initialPosition: initialWithOffset,
                  finalPoisition: finalWithOffset));
      items.add(item);
      index++;
    }
    return items;
  }
}
