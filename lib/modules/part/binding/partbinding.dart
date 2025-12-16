import 'package:flutter_application_10/modules/part/controller/partcontroller.dart';
import 'package:get/get.dart';
class Partbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Partcontroller>(()=>Partcontroller());
  }
}