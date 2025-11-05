import 'package:flutter_application_10/data/models/provincemodel.dart';
import 'package:flutter_application_10/modules/province/provinceservice/provinceservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Provincecontroller extends GetxController {
  final Provinceservice provinceservice = Provinceservice();

  var provinces = <Data>[].obs; // ✅ Correct type

  @override
  void onInit() {
    fetchprovince();
    super.onInit();
  }

  Future<void> fetchprovince() async {
    try {
      final result = await provinceservice.getProvince();
      provinces.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }
}
