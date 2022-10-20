

import 'package:vidavo_devices/wearable_connection.dart';

class WearableStates{

 late String _e ;
 Future<String> connect() async {
  WearableConnection().statusStream.listen((event) {
   if(event ==  WearableStatus.connected){
    _e  = "Connected";
   }
  });
  return  _e;
 }



}
