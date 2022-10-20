

import 'package:vidavo_devices/wearable_connection.dart';

class WearableStates{

 String connect(){
  return  WearableConnection().connected();
 }

 String disconnected(){
   return  WearableConnection().disconnected();
 }


}
