import 'package:flutter_application_10/modules/communce/communcecontroller/communcecontroller.dart';
import 'package:get/get.dart';

class Communcebinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Communcecontroller>(() => Communcecontroller());
  }
}
