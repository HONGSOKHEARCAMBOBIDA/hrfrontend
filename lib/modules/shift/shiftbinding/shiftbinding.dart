import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:get/get.dart';
class Shiftbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Shiftcontroller>(() => Shiftcontroller());
  }
}