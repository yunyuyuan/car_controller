import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mutex/mutex.dart';

class BluetoothClient{
  final BluetoothDevice server;
  BluetoothConnection connection;
  final lock = Mutex();

  BluetoothClient({this.server});

  Future connect(Function disconnectHandle) async {
    var handle = Completer();
    BluetoothConnection.toAddress(server.address).then((_connection){
      connection = _connection;
      recv(disconnectHandle);
      handle.complete();
    }).onError((error, stackTrace){
      handle.completeError(error);
    });
    return handle.future;
  }

  disconnect(){
    connection.close();
  }

  send(Map<String, dynamic> data) async {
    if (lock.isLocked) return;
    lock.acquire();
    connection.output.add(utf8.encode(jsonEncode(data)));
    await connection.output.allSent;
    lock.release();
  }

  recv(Function disconnectHandle){
    connection.input.listen((Uint8List data) {
      connection.output.add(data); // Sending data

      if (ascii.decode(data).contains('!')) {
        disconnect();
        print('!!!! Disconnecting by local host');
        disconnectHandle();
      }
    }).onDone(() {
      print('!!!! Disconnected by remote request');
      disconnectHandle();
    });
  }
}