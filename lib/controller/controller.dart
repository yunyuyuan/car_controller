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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 40, right: 30, top: 30),
                  child: MySlider(
                    orient: Orients.vertical,
                    disabled: widget.disabled,
                    valueChange: (value) {
                      widget.client
                          .send({"type": "left-right", "value": value});
                    },
                  ),
                ),
                Flexible(
                  flex: 0,
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
          Flexible(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 40, bottom: 30),
                child: MySlider(
                  orient: Orients.horizontal,
                  disabled: widget.disabled,
                  valueChange: (value) {
                    widget.client
                        .send({"type": "forward-backward", "value": value});
                  },
                ),
              ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
