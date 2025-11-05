import 'package:flutter_application_10/modules/leave/leavecontroller/leavecontroller.dart';
import 'package:get/get.dart';
class Leavebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Leavecontroller>(()=>Leavecontroller());
  }
}