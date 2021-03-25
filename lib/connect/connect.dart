import 'dart:async';
import 'dart:developer';

import 'package:car_controller/connect/device_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_setting/system_setting.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Connect extends StatefulWidget {

  Connect ():super();

  @override
  State<StatefulWidget> createState() => ConnectState();
}

class ConnectState extends State<Connect> {
  var refreshing;
  List<BluetoothDevice> connectedDevices = [];
  BluetoothDevice active;

  @override
  void initState() {
    super.initState();

    refreshing = false;
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton.icon(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            onPressed: () {
              SystemSetting.goto(SettingTarget.BLUETOOTH);
            },
            label: Text('open system bluetooth setting')),
        TextButton.icon(
            icon: Icon(
              Icons.autorenew,
              size: 20,
            ),
            onPressed: () {
              refresh();
            },
            label: Text(refreshing?'refreshing...':'refresh')),
        Expanded(
          child: ListView(children:
          connectedDevices.map((e) => DeviceItem(
            device: e,
            active: e==active,
            onTap: (){
              setState(() {
                active = e;
              });
            },
          )).toList()
          )
        )
      ],
    ));
  }

  Future<void> refresh() async {
    refreshing = true;
    setState(() {
      connectedDevices = [];
    });
    FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> _devices) {
      setState(() {
        connectedDevices = _devices.where((e) => e.isConnected).toList();
      });
    }).whenComplete(() {
      setState(() {
        refreshing = false;
      });
    });
  }
}
