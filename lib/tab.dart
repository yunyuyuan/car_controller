import 'package:flutter/material.dart';

class MyTabView extends DefaultTabController {
  MyTabView({Key key, String title, bool connected, int length, children})
      : super(
          key: key,
          length: length,
          child: Scaffold(
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.control_camera,
                    size: 30,
                  ),
                  text: "Control",
                  iconMargin: const EdgeInsets.only(bottom: 3.0),
                ),
                Tab(
                  icon: Icon(Icons.link, size: 30),
                  text: "Connect",
                  iconMargin: const EdgeInsets.only(bottom: 3.0),
                ),
              ],
              labelColor: Colors.greenAccent,
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              indicatorColor: Colors.transparent,
            ),
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    title,
                  ),
                  Text(
                    '(${connected ? "已" : "未"}连接)',
                    style: TextStyle(color: connected?Color(0xff7ffffb):Color(0xffff8f8f)),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              // disable swipe
              physics: NeverScrollableScrollPhysics(),
              children: children,
            ),
            backgroundColor: Colors.black87,
          ),
        );
}
