import 'package:flutter_application_10/data/models/partmodel.dart';
import 'package:flutter_application_10/modules/part/service/partservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Partcontroller extends GetxController {
  final Partservice partservice = Partservice();
  var parts = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchpart(); // Fetch all roles by default
    super.onInit();
  }

  Future<void> fetchpart() async {
    try {
      isLoading.value = true;
      final result = await partservice.getpart();
      parts.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }finally{
      isLoading.value= false;
    }
  }
}
