import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:car_controller/connect/device_item.dart';
import 'package:car_controller/util/iconfont.dart';
import 'package:car_controller/util/sender.dart';
import 'package:car_controller/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              IconFont.setting,
              size: 16,
            ),
            onPressed: ()async {
              AppSettings.openBluetoothSettings();
            },
            label: Text('open system bluetooth setting')),
        TextButton.icon(
            icon: Icon(
              IconFont.refresh,
              size: 16,
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
                            if (connecting != null ||
                                active?.address == e.address) return;
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
                              var _ = await instance.connect((String message) {
                                // disconnected
                                setState(() {
                                  active = null;
                                  connecting = null;
                                });
                                widget.changeClient(null);

                                Util.showSnackbar(
                                    context: context,
                                    message: message,
                                    icon: Icon(
                                      IconFont.disconnected,
                                      size: 20,
                                      color: Colors.redAccent,
                                    ));
                              });
                              setState(() {
                                active = e;
                                widget.changeClient(instance);
                              });
                            } catch (err) {
                              Util.showSnackbar(
                                  context: context,
                                  message: err.toString(),
                                  icon: Icon(
                                    IconFont.err,
                                    size: 20,
                                    color: Colors.redAccent,
                                  ));
                            }
                            setState(() {
                              connecting = null;
                            });
                          },
                          onLongPress: () {
                            if (active?.address != e.address) return;
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text("断开 ${e.name} 连接?"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                          },
                                          child: Text("取消",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xff727272)),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                              setState(() {
                                                active = null;
                                                connecting = null;
                                              });
                                              widget.changeClient(null);
                                            },
                                            child: Text("确定",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Color(0xFFFF1F1F)),
                                            )),
                                      ],
                                    ),
                                barrierDismissible: true);
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
