import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:get/get.dart';

class MainBinding  extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
   Get.lazyPut(() => MainController());

    //Get.put(MainController());
  }
}