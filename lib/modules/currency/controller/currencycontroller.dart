import 'package:flutter_application_10/data/models/currencymodel.dart';
import 'package:flutter_application_10/modules/branch/branchservice/branchservice.dart';
import 'package:flutter_application_10/modules/currency/service/currencyservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Currencycontroller extends GetxController {
  final Currencyservice currencyservice = Currencyservice();
  var currency = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchcurrency(); // Fetch all roles by default
    super.onInit();
  }

  Future<void> fetchcurrency() async {
    try {
      final result = await currencyservice.getcurrency();
      currency.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createcurrency({
    required String code,
    required String symbol,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      bool created = await currencyservice.createcurrency(
        name: name,
        symbol: symbol,
        code: code,
      );
      if (created) {
        await fetchcurrency();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = true;
    }
  }

  Future<void> updatecurrency({
    required String code,
    required String symbol,
    required String name,
    required int currencyID,
  }) async {
    try {
      isLoading.value = true;
      bool updated = await currencyservice.updatecurrency(
        name: name,
        symbol: symbol,
        code: code,
        currencyID: currencyID,
      );
      if (updated) {
        Get.back();
        await fetchcurrency();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatuscurrency({required int currencyID}) async {
    try {
      isLoading.value = true;
      bool updated = await currencyservice.changestatuscurrency(
        currencyID: currencyID,
      );
      if (updated) {
        await fetchcurrency();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
