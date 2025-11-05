import 'package:flutter_application_10/data/models/shftmodel.dart';
import 'package:flutter_application_10/modules/shift/shiftservice/shiftservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Shiftcontroller extends GetxController {
  final Shiftservice shiftservice = Shiftservice();
  var shift = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchshift(int? branchid) async {
    try {
      final resutl = await shiftservice.getshift(branchid);
      shift.assignAll(resutl);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> fetchallshift() async {
    try {
      final result = await shiftservice.getallshift();
      shift.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createshift({
    required String name,
    required String start_time,
    required String end_time,
    required int branchid,
  }) async {
    try {
      isLoading.value = true;
      bool create = await shiftservice.CreateShift(
        name: name,
        start_time: start_time,
        end_time: end_time,
        branchid: branchid,
      );
      if (create) {
        await fetchallshift();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
