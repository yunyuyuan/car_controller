import 'package:car_controller/controller/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Controller extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ControllerState();
}

class ControllerState extends State<Controller> {
  double leftValue = 0;
  double forwardValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: <Widget>[
            MySlider(orient: Orients.vertical),
            SizedBox(height: 100),
            MySlider(orient: Orients.horizontal),
          ],
        ),
      )
    );
  }
}
