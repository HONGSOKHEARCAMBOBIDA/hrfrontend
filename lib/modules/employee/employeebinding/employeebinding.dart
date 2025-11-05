import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:get/get.dart';
class Employeebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Employeecontroller>(()=>Employeecontroller());
  }
}