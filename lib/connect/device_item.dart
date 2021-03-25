import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceItem extends ListTile {
  final BluetoothDevice device;
  final bool active;
  final GestureTapCallback onTap;

  DeviceItem({this.device, this.active, this.onTap}) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFDBDBDB),
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
              Icons.adjust_outlined,
              size: 24,
              color: active ? Colors.indigoAccent : Colors.white.withOpacity(0),
            ),
          ],
        ),
      )
    );
  }
}
