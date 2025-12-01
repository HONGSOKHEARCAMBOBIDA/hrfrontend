import 'package:flutter_application_10/data/models/currencypairmodel.dart';
import 'package:flutter_application_10/modules/currencypair/service/currencypairservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Currencypaircontroller extends GetxController {
  final Currencypairservice currencypairservice = Currencypairservice();
  var currencypair = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchcurrencypair(); // Fetch all roles by default
    super.onInit();
  }

  Future<void> fetchcurrencypair() async {
    try {
      final result = await currencypairservice.getcurrencypair();
      currencypair.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }
}
