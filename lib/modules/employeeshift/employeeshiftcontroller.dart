import 'package:flutter_application_10/data/models/employeeshiftmodel.dart';
import 'package:flutter_application_10/modules/attendance/service/attendanceservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
class Employeeshiftcontroller extends GetxController{
  final Attendanceservice attendanceservice = Attendanceservice();
  var employeeshift = <Data>[].obs;
  var isLoading = false.obs;
    var selectedShiftId = Rxn<int>();
  @override
  void onInit() {
    super.onInit();
  fetchemployeeshift();
  }
    void selectShift(int id) {
    if (selectedShiftId.value == id) {
      selectedShiftId.value = null;
    } else {
      selectedShiftId.value = id;
    }
  }
    Future<void> fetchemployeeshift() async {
    try {
      isLoading.value = true;
      final result = await attendanceservice.getemployeeshift();
      employeeshift.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}