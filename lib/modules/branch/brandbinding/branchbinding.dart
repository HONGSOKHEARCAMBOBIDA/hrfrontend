import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:get/get.dart';
class Branchbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Branchcontroller>(()=>Branchcontroller());
  }
}