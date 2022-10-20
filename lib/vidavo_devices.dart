library vidavo_devices;

import 'package:vidavo_devices/wearable_connection.dart';
import 'package:vidavo_devices/wearable_states.dart';



 class VidavoDevices {
  WearableStates wearable = WearableStates();

  Future<String> returnStrinExample(){
   return wearable.connect();
  }
  void connect(){
     WearableConnection().init();

  }

  void connected(){
  }

  void disconnected(){}

   void timeout(){}
}


