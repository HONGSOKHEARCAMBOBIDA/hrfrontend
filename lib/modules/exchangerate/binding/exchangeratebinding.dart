import 'package:flutter_application_10/modules/exchangerate/controller/exchangratecontroller.dart';
import 'package:get/get.dart';
class Exchangeratebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Exchangratecontroller>(()=>Exchangratecontroller());
    
  }
}