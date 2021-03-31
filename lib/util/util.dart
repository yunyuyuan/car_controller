import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util {
  static showSnackbar({BuildContext context, String message, Icon icon}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      margin: EdgeInsets.only(bottom: 100, left: 30, right: 30),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xffffcaca),
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      content: Row(
        children: [
          Container(margin: EdgeInsets.only(right: 15), child: icon),
          Expanded(
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    ));
  }
}
