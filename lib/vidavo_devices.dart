library vidavo_devices;

import 'package:vidavo_devices/wearable_connection.dart';



 class VidavoDevices {



  void connect(){
     WearableConnection().findEndConnect();

  }

  void connected(){
  }

  void disconnected(){}

   void timeout(){}
}


