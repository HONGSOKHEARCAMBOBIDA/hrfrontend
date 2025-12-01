import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:get/get.dart';
class Currencybinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Currencycontroller>(()=>Currencycontroller());
  }
}