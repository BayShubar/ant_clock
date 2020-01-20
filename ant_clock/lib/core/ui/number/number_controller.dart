import 'package:flutter/material.dart';
import 'package:digital_clock/core/model/ant.dart';
import 'package:digital_clock/core/model/indexed_key.dart';
import 'package:digital_clock/core/ui/ant/ant_item.dart';

class NumberController extends StatefulWidget {
  final GlobalKeyToIdManager<AntItemState, AntData> ants;

  NumberController({Key key, @required this.ants}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NumberControllerState();
  }
}

class NumberControllerState extends State<NumberController> {
  GlobalKeyToIdManager<AntItemState, AntData> get _ants => widget.ants;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildAnts,
    );
  }

  // CONTROLLER

  void show(List<int> showIndexes) {
    for (int id in showIndexes) {
      _ants.findById(id).globalKey.currentState.show();
    }
  }

  void hide(List<int> showIndexes) {
    for (int id in showIndexes) {
      _ants.findById(id).globalKey.currentState.hide();
    }
  }

  List<Widget> get _buildAnts {
    List<Widget> res = [];
    for (GlobalKeyToId<AntItemState, AntData> item in _ants.list) {
      res.add(AntItem(
        antData: item.data,
        key: item.globalKey,
      ));
    }
    return res;
  }
}
