import 'package:car_controller/connect.dart';
import 'package:car_controller/controller.dart';
import 'package:car_controller/tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String appTitle = 'Car Controller';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTabView(title: appTitle, length: 2, children: [
        Controller(),
        Connect(),
      ]),
    );
  }
}