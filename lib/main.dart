import 'package:car_controller/connect/connect.dart';
import 'package:car_controller/controller/controller.dart';
import 'package:car_controller/tab.dart';
import 'package:car_controller/sender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Car Controller';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: _Container(title: appTitle),
    );
  }
}

class _Container extends StatefulWidget {
  final String title;

  _Container({this.title}) : super();

  @override
  State<StatefulWidget> createState() => _ContainerState();
}

class _ContainerState extends State<_Container> {
  BluetoothClient client;

  @override
  void initState() {
    client = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyTabView(
          title: widget.title,
          length: 2,
          children: [
            Controller(client: client,),
            Connect(changeClient: changeClient, client: client,),
          ]),
    );
  }

  void changeClient(BluetoothClient _client) {
    setState(() {
      client = _client;
    });
  }
}
