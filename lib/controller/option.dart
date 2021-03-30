import 'package:car_controller/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionView extends StatefulWidget{
  final Function(double val) changeSpeedStrength;
  final Function(double val) changeSteerAngle;

  const OptionView({Key key, this.changeSpeedStrength, this.changeSteerAngle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OptionViewState();
}

class OptionViewState extends State<OptionView>{
  double speedStrength = 1.0;
  double steerAngle = 15.0;

  @override
  void initState() {
    // first time init
    widget.changeSpeedStrength(speedStrength);
    widget.changeSteerAngle(steerAngle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform(
        transform: Matrix4.rotationZ(90 * Util.arc),
        alignment: FractionalOffset.center,
        child: Column(
          children: [
            Row(
              children: [
                Text("速度倍率"),
                Slider(value: speedStrength, divisions: 4, min: 1, max: 5, onChanged: (double val){
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
              children: [
                Text("转弯角度"),
                Slider(value: steerAngle, divisions: 15, min: 15.0, max: 90.0, onChanged: (double val){
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
      ),
    );
  }
}