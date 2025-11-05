import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:get/get.dart';
class Authbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Authcontroller>(()=>Authcontroller());
  }
}