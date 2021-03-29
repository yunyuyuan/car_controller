import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceItem extends ListTile {
  final BluetoothDevice device;
  final bool active;
  final bool connecting;
  final GestureTapCallback onTap;

  DeviceItem({this.device, this.active, this.onTap, this.connecting}) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 15, right: 15),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFBEFFDA),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [BoxShadow(
            color: Color(0xFF29A2FF),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 0))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.devices,
              size: 24,
            ),
            Text(device.name),
            Icon(
              connecting?Icons.autorenew:Icons.adjust_outlined,
              size: 24,
              color: active ? Colors.indigoAccent : Colors.white.withOpacity(0),
            ),
          ],
        ),
      )
    );
  }
}
