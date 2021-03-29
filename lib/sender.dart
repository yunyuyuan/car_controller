import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mutex/mutex.dart';

class BluetoothClient{
  final BluetoothDevice server;
  BluetoothConnection connection;
  final lock = Mutex();

  BluetoothClient({this.server});

  Future connect() async {
    var handle = Completer();
    BluetoothConnection.toAddress(server.address).then((_connection){
      connection = _connection;
      handle.complete();
    }).onError((error, stackTrace){
      handle.completeError(error);
    });
    return handle.future;
  }

  disconnect(){
    connection.dispose();
  }

  send(Map<String, dynamic> data) async {
    if (lock.isLocked) return;
    lock.acquire();
    connection.output.add(utf8.encode(jsonEncode(data)));
    await connection.output.allSent;
    lock.release();
  }

  recv(){

  }
}