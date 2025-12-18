import 'package:flutter_application_10/modules/attendance/controller/attendancecontroller.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:get/get.dart';
class Attendancebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Attendancecontroller>(()=>Attendancecontroller());
    Get.lazyPut<MainController>(()=>MainController());
  }
}