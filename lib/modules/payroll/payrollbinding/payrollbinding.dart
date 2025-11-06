import 'package:flutter_application_10/modules/payroll/payrollcontroller/payrollcontroller.dart';
import 'package:get/get.dart';
class Payrollbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Payrollcontroller>(()=>Payrollcontroller());
  }
}