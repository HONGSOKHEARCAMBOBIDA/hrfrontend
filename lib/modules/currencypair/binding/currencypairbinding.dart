import 'package:flutter/cupertino.dart';
import 'package:flutter_application_10/modules/currencypair/controller/currencypaircontroller.dart';
import 'package:get/get.dart';
class Currencypairbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Currencypaircontroller());
  }
}
