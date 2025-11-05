import 'package:flutter_application_10/modules/loan/loancontroller/loancontroller.dart';
import 'package:get/get.dart';
class Loanbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoanController>(()=>LoanController());
  }
}