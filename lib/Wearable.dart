import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class WearableConnection{
  late StreamSubscription subscriptionFindAndConnect;

   findEndConnect()  {
    FlutterBlue.instance.startScan(timeout: const Duration(seconds: 10));
    Stream<List<ScanResult>> scanStream = FlutterBlue.instance.scanResults;
    subscriptionFindAndConnect = scanStream.listen((event) {
      event.forEach((element)  {
        if (element.device.name.startsWith("Vidavo_") ) {
          FlutterBlue.instance.stopScan();
          print("hello world");
          subscriptionFindAndConnect.cancel();
        }
      });
    });
  }


}
