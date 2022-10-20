import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';



class WearableConnection {


  late StreamSubscription subscriptionFindAndConnect;
  late String connectedString  = "";


  late StreamController<dynamic> _statusStreamController;
  late Stream<dynamic> statusStream;
  late Sink<dynamic> _statusSink;


   init(
     ) {
    _statusStreamController =  StreamController<dynamic>.broadcast();
    statusStream = _statusStreamController.stream;
    _statusSink = _statusStreamController.sink;
    findEndConnect();
  }


  void findEndConnect() {
    FlutterBlue.instance.startScan(timeout: const Duration(seconds: 10));
    Stream<List<ScanResult>> scanStream = FlutterBlue.instance.scanResults;
    subscriptionFindAndConnect = scanStream.listen((event) {
      event.forEach((element) {
        if (element.device.name.startsWith("Vidavo_")) {
          FlutterBlue.instance.stopScan();
          connectedString = "Connected";
          print("VIDAVO_DEVICES: CONNECTED WEARABLE ");
        //  connected = "connected";
       //   startExam(element.device, element.device.id.toString());
          _statusSink.add(WearableStatus.connected);
          subscriptionFindAndConnect.cancel();
          dispose();


        }
      });
    });

  //  return  connected;
  }

  void dispose(){

    _statusStreamController.close();
  }

}





//   startExam(BluetoothDevice device, String MACADDRESS) async {
//     List<BluetoothDevice> devices = await FlutterBlue.instance.connectedDevices;
//     if (!devices.contains(device)) {
//       await device.connect();
//     }
//     StreamSubscription deviceStatus;
//     deviceStatus = device.state.listen((state) async {
//       if (state == BluetoothDeviceState.connected) {
//         _statusSink.add(WearableStatus.connected);
//
//         List<BluetoothService> services = await device.discoverServices();
//
//         var vidavoService = services.firstWhere(
//                 (service) =>
//             service.uuid.toString() ==
//                 "e04f8554-2e6d-10a6-ae48-de69f841a092",
//             orElse: () => null);
//
//         var serviceInfoBattery = services.firstWhere(
//                 (service) =>
//             service.uuid.toString() ==
//                 "e04f8554-2e6d-10a6-ae48-de69f841a094",
//             orElse: () => null);
//
//         var allDayMeasurementService = services.firstWhere(
//                 (patientService) =>
//             patientService.uuid.toString() ==
//                 "e04f8554-2e6d-10a6-ae48-de69f841a098",
//             orElse: () => null);
//
//         var notifyCharachteristic = vidavoService.characteristics.firstWhere(
//                 (characteristic) =>
//             characteristic.uuid.toString() ==
//                 "e04f8554-2e6d-10a6-ae48-de69f942a193",
//             orElse: () => null);
//         StreamSubscription streamForCancelation;
//         StreamSubscription streamForCancelation1;
//         try{
//           await notifyCharachteristic.read();
//           await notifyCharachteristic
//               .setNotifyValue(!notifyCharachteristic.isNotifying);
//           streamForCancelation =
//               notifyCharachteristic.value.listen((values) async {
//                 if (values.isNotEmpty) {
//                   if (values.length > 0) {
//                     var bpm = values[4];
//                     var spo2 = values[5];
//                     var rr = values[6];
//                     var bodyTemperature1 = values[7];
//                     var bodyTemperature2 = values[8];
//                     String bodyTemperatureString =
//                         "${bodyTemperature1}.${bodyTemperature2}";
//                     double bodyTemperatureDouble =
//                     double.parse(bodyTemperatureString);
//                     print(
//                         "First service  ${bpm} ${spo2} ${rr} ${bodyTemperature1} ${bodyTemperature2}");
//                     _wearableResponse =
//                         WearableResponse(bpm, spo2, rr, bodyTemperatureDouble);
//                     //  print(" PRWTO PRIN EINAI EDW " + values.toString());
//                   }
//
//                   var notifyCharachteristicBattery =
//                   serviceInfoBattery.characteristics.firstWhere(
//                         (characteristic) =>
//                     characteristic.uuid.toString() ==
//                         "e04f8554-2e6d-10a6-ae48-de69f841a095",
//                   );
//                   await notifyCharachteristicBattery.read();
//
//                   notifyCharachteristicBattery.value.listen((event) async {
//                     if (event.length > 0) {
//                       if (event.isNotEmpty) {
//                         var battery = event[14];
//                         _wearableBattery = WearableBattery(battery);
//                         print("Wearable battery ${battery}");
//                       }
//                     }
//                   });
//
//                   var allDayMeasurementCharacteristic =
//                   allDayMeasurementService.characteristics.firstWhere((element) =>
//                   element.uuid.toString() ==
//                       "e04f8554-2e6d-10a6-ae48-de69f841a099");
//
//                   await allDayMeasurementCharacteristic.read();
//
//                   streamForCancelation1 =
//                       allDayMeasurementCharacteristic.value.listen((event) async {
//                         if (event.length > 0) {
//                           if (event.isNotEmpty) {
//                             var bpmAvg = event[0];
//                             var bpmMin = event[1];
//                             var bpmMax = event[2];
//                             var steps1 = event[3];
//                             var steps2 = event[4];
//                             var calories1 = event[5];
//                             var calories2 = event[6];
//
//                             String stepsString = "${steps1}${steps2}";
//                             int steps = int.parse(stepsString);
//
//                             String caloriesString = "${calories1}${calories2}";
//                             int calories = int.parse(caloriesString);
//                             print("all day measurement ============> ${bpmAvg} "
//                                 "${bpmMin} "
//                                 "${bpmMax} "
//                                 "${steps} "
//                                 "${calories}");
//
//                             _wearableAllDayMeasurements = WearableAllDayMeasurements(
//                                 bpmMin, bpmMax, steps, calories, bpmAvg);
//                             _statusSink.add(WearableStatus.disconnected);
//                             await streamForCancelation.cancel();
//                             await streamForCancelation1.cancel();
//                             await deviceStatus.cancel();
//                             await device.disconnect();
//
//                             _dispose(device);
//                             if (_wearableAllDayMeasurements != null &&
//                                 _wearableResponse != null &&
//                                 _wearableBattery != null) {
//                               var macAdressRegex =  MACADDRESS.replaceAll(":", "");
//                               await _sendData(_wearableAllDayMeasurements,
//                                   _wearableResponse, _wearableBattery, macAdressRegex);
//                             }
//                           }
//                         }
//                       });
//                 }
//               });
//         }catch(e){
//           log("read is null");
//           _statusSink.add(WearableStatus.disconnected);
//           await streamForCancelation.cancel();
//           await streamForCancelation1.cancel();
//           await deviceStatus.cancel();
//           await device.disconnect();
//
//         }
//       }
//     });
//   }
//
//   _dispose(BluetoothDevice device) {
//     _statusStreamController.close();
//     _statusStreamController = null;
//     FlutterBlue.instance.stopScan();
//   }
//
//
// }



  enum WearableStatus {
     connected,
     disconnected,
     finished,
     failed, }



