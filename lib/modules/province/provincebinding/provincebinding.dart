import 'package:flutter_application_10/modules/province/provincecontroller/provincecontroller.dart';
import 'package:get/get.dart';

class Provincebinding extends Bindings {
  @override
  void dependencies() {
    // Lazy put: creates the controller only when it's used
    Get.lazyPut<Provincecontroller>(() => Provincecontroller());
  }
}
