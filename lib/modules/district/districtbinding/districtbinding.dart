import 'package:flutter_application_10/modules/district/districtcontroller/districtcontroller.dart';
import 'package:get/get.dart';

class Districtbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Districtcontroller>(() => Districtcontroller());
  }
}
