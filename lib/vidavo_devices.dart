library vidavo_devices;

import 'package:vidavo_devices/bf600.dart';
import 'package:vidavo_devices/Wearable.dart';



 class VidavoDevices {


  String connectWearable(){
  return  WearableConnection().findEndConnect();

  }
}

