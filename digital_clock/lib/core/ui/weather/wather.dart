import 'package:digital_clock/core/model/sizer.dart';
import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  final String temp;
  final String weather;

  const Weather({Key key, @required this.temp, @required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Sizer().getHeight(50),
      left: Sizer().getWidth(50),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: Sizer().getWidth(150),
              width: Sizer().getWidth(150),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/$weather.png'))),
            ),
            SizedBox(
              width: Sizer().getWidth(50),
            ),
            Container(
              child: Text(
                temp,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizer().getFont(80),
                    fontWeight: FontWeight.w100),
              ),
            )
          ],
        ),
      ),
    );
  }
}
