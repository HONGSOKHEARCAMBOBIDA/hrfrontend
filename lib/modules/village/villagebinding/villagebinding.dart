import 'package:flutter_application_10/modules/village/villagecontroller/villagecontroller.dart';
import 'package:get/get.dart';
class Villagebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Villagecontroller>(()=>Villagecontroller());
  }
}