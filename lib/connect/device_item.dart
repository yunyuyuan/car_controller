import 'package:car_controller/util/iconfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceItem extends ListTile {
  final BluetoothDevice device;
  final bool active;
  final bool connecting;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;

  DeviceItem({this.device, this.active, this.onTap, this.connecting, this.onLongPress}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
      child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Ink(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFBEFFDA),
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [BoxShadow(
                  color: Color(0xFF3EAAFF),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 0))
              ],
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.devices,
                    size: 24,
                  ),
                  Text(device.name),
                  connecting?
                  SizedBox(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    height: 24,
                    width: 24,
                  ):
                  Icon(
                    IconFont.connected,
                    size: 24,
                    color: active ? Colors.indigoAccent : Colors.white.withOpacity(0),
                  ),
                ],
              ),
            ),
          )
      )
    );
  }
}
