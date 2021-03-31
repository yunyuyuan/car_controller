import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionView extends StatefulWidget {
  final Function(double val) changeSpeedStrength;
  final Function(double val) changeSteerAngle;
  final bool disabled;

  const OptionView(
      {Key key, this.changeSpeedStrength, this.changeSteerAngle, this.disabled})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => OptionViewState();
}

class OptionViewState extends State<OptionView> {
  double speedStrength = 1.0;
  double steerAngle = 15.0;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi/2,
      origin: Offset(-40, 40),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("速度倍率"),
              Slider(
                  value: speedStrength,
                  divisions: 7,
                  min: 1,
                  max: 8,
                  onChanged: (double val) {
                    if (widget.disabled) return;
                    var newVal = val;
                    if (newVal == speedStrength) return;
                    setState(() {
                      speedStrength = val;
                    });
                    widget.changeSpeedStrength(val);
                  }),
              Text(speedStrength.toString()),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("转弯角度"),
              Slider(
                  value: steerAngle,
                  divisions: 15,
                  min: 15.0,
                  max: 90.0,
                  onChanged: (double val) {
                    if (widget.disabled) return;
                    var newVal = val;
                    if (newVal == steerAngle) return;
                    setState(() {
                      steerAngle = val;
                    });
                    widget.changeSteerAngle(val);
                  }),
              Text("${steerAngle.toString()}°"),
            ],
          ),
        ],
      ),
    );
  }
}
