import 'package:flutter_application_10/data/models/exchangeratemodel.dart';
import 'package:flutter_application_10/modules/exchangerate/service/exchangrateservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Exchangratecontroller extends GetxController {
  final Exchangrateservice exchangrateservice = Exchangrateservice();
  var exchangerate = <Data>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchexchangrate(); // Fetch all roles by default
    super.onInit();
  }

  Future<void> fetchexchangrate() async {
    try {
      final result = await exchangrateservice.getexchangreate();
      exchangerate.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createexchangerate({
    required int pairID,
    required double rate,
  }) async {
    try {
      isLoading.value = true;
      bool iscreate = await exchangrateservice.createexchangerate(
        pairID: pairID,
        rate: rate,
      );
      if (iscreate) {
        await fetchexchangrate();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateexchangerate({
    required int ID,
    required int pairID,
    required double rate,
  }) async {
    try {
      isLoading.value = true;
      bool update = await exchangrateservice.updateexchangerate(
        exchangerateID: ID,
        pairID: pairID,
        rate: rate,
      );
      if (update) {
        await fetchexchangrate();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusexchangerate({required int ID}) async {
    try {
      isLoading.value = true;
      bool updated = await exchangrateservice.changestatusexchangerate(
        exchangerateID: ID,
      );
      if (updated) {
        await fetchexchangrate();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
