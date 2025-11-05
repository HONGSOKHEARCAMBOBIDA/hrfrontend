import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:get/get.dart';
class Rolebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Rolecontroller>(()=>Rolecontroller(),);
    
  }
}