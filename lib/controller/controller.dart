import 'package:car_controller/controller/option.dart';
import 'package:car_controller/controller/slider.dart';
import 'package:car_controller/util/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Controller extends StatefulWidget {
  final BluetoothClient client;
  final bool disabled;

  Controller({this.client, this.disabled}) : super();

  @override
  State<StatefulWidget> createState() => ControllerState();
}

class ControllerState extends State<Controller>
    with AutomaticKeepAliveClientMixin<Controller> {
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
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: MySlider(
                    orient: Orients.vertical,
                    disabled: widget.disabled,
                    valueChange: (value) {
                      widget.client
                          .send({"type": "left-right", "value": value});
                    },
                  ),
                ),
                Expanded(
                    child: OptionView(
                  disabled: widget.disabled,
                  changeSpeedStrength: (val) {
                    widget.client
                        .send({"type": "speed-strength", "value": val});
                  },
                  changeSteerAngle: (val) {
                    widget.client.send({"type": "steer-angle", "value": val});
                  },
                )),
              ],
            ),
          ),
          // left - right
          SizedBox(height: 100),
          // forward - backward
          MySlider(
            orient: Orients.horizontal,
            disabled: widget.disabled,
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
