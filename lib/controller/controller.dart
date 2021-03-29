import 'package:car_controller/controller/slider.dart';
import 'package:car_controller/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Controller extends StatefulWidget {
  final BluetoothClient client;

  Controller({this.client}) : super();

  @override
  State<StatefulWidget> createState() => ControllerState();
}

class ControllerState extends State<Controller> with AutomaticKeepAliveClientMixin<Controller> {
  double leftValue = 0;
  double forwardValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // left - right
          MySlider(
            orient: Orients.vertical,
            valueChange: (value) {
              widget.client.send({"type": "left-right", "value": value});
            },
          ),
          SizedBox(height: 100),
          // forward - backward
          MySlider(
            orient: Orients.horizontal,
            valueChange: (value) {
              widget.client.send({"type": "forward-backward", "value": value});
            },
          ),
        ],
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
