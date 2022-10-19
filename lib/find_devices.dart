import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class ScanBluetooth{
  late StreamSubscription subscriptionFindAndConnect;

  findDevice()  {
    FlutterBlue.instance.startScan(timeout: const Duration(seconds: 10));
    Stream<List<ScanResult>> scanStream = FlutterBlue.instance.scanResults;
    subscriptionFindAndConnect = scanStream.listen((event) {
      event.forEach((element)  {
        if (element.device.name.startsWith("BF600") ) {
          FlutterBlue.instance.stopScan();
          print("hello world");
          subscriptionFindAndConnect.cancel();
        }
      });
    });
  }


}
