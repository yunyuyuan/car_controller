import 'package:flutter/material.dart';

class MyTabView extends DefaultTabController {
  MyTabView({Key key, String title, int length, children})
      : super(
          key: key,
          length: length,
          child: Scaffold(
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.control_camera, size: 26,
                  ),
                  text: "Control",
                  iconMargin: const EdgeInsets.only(bottom: 5.0),
                ),
                Tab(
                  icon: Icon(Icons.bluetooth_connected, size: 26),
                  text: "Connect",
                  iconMargin: const EdgeInsets.only(bottom: 5.0),
                ),
              ],
              labelColor: Colors.greenAccent,
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal
              ),
              indicatorColor: Colors.transparent,
            ),
            appBar: AppBar(
              title: Text(title),
            ),
            body: TabBarView(
              // disable swipe
              physics: NeverScrollableScrollPhysics(),
              children: children,
            ),
            backgroundColor: Colors.white30,
          ),
        );
}
