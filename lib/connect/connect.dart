import 'dart:async';
import 'dart:developer';

import 'package:car_controller/connect/device_item.dart';
import 'package:car_controller/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_setting/system_setting.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Connect extends StatefulWidget {
  final Function changeClient;
  final BluetoothClient client;

  Connect({this.changeClient, this.client}) : super();

  @override
  State<StatefulWidget> createState() => ConnectState();
}

class ConnectState extends State<Connect>
    with AutomaticKeepAliveClientMixin<Connect> {
  var refreshing;
  BluetoothDevice connecting;
  List<BluetoothDevice> connectedDevices = [];
  BluetoothDevice active;

  @override
  void initState() {
    super.initState();

    refreshing = false;
    connecting = null;
    active = null;
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
              Icons.refresh,
              size: 20,
            ),
            onPressed: () {
              refresh();
            },
            label: Text(refreshing ? 'refreshing...' : 'refresh')),
        Expanded(
            child: ListView(
                children: connectedDevices
                    .map((e) => DeviceItem(
                          device: e,
                          active: e.address == active?.address,
                          connecting: connecting?.address == e.address,
                          onTap: () async {
                            if (connecting != null || active?.address == e.address) return;
                            // disconnect
                            if (widget.client != null) {
                              try {
                                widget.client.disconnect();
                                setState(() {
                                  active = null;
                                });
                              } catch (_) {}
                            }
                            setState(() {
                              connecting = e;
                            });
                            var instance = BluetoothClient(server: e);
                            try {
                              var _ = await instance.connect();
                              setState(() {
                                active = e;
                                widget.changeClient(instance);
                              });
                            } catch (err) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      margin: EdgeInsets.only(
                                          bottom: 100, left: 30, right: 30),
                                      content: Container(
                                        child: Text(err.toString()),
                                        height: 50,
                                      ),
                                      behavior: SnackBarBehavior.floating));
                            }
                            setState(() {
                              connecting = null;
                            });
                          },
                        ))
                    .toList()))
      ],
    ));
  }

  Future<void> refresh() async {
    refreshing = true;
    setState(() {
      connectedDevices = [];
    });
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> _devices) {
      setState(() {
        connectedDevices = _devices.where((e) => e.isConnected).toList();
      });
    }).whenComplete(() {
      setState(() {
        refreshing = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
