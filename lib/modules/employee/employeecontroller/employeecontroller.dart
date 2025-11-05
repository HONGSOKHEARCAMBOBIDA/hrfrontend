import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/data/models/employeeupdatemodel.dart';
import 'package:flutter_application_10/modules/employee/employeeservice/employeeservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Employeecontroller extends GetxController {
  final Employeeservice employeeservice = Employeeservice();
  var employees = <Data>[].obs;
  final RxString searchQuery = ''.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // Fetch all users first
    fetchemployee();

    // Debounce search
    debounce(
      searchQuery, // Rx value to watch
      (_) => fetchemployee(name: searchQuery.value), // Action to run
      time: const Duration(milliseconds: 200), // Wait 500ms after last input
    );

    super.onInit();
  }

  Future<void> fetchemployee({
    int? branchid,
    int? roleid,
    int? isActive,
    String? name,
    int? shiftid,
  }) async {
    try {
      isLoading.value = true;
      final result = await employeeservice.getemployee(
        branchid: branchid,
        roleid: roleid,
        isActive: isActive,
        name: name,
        shiftid: shiftid,
      );
      employees.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateemployee(Employeeupdatemodel employee) async {
    try {
      isLoading.value = true;
      bool isupdated = await employeeservice.updateemployee(employee);
      if (isupdated == true) {
        await fetchemployee();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusemployee(int? id) async {
    try {
      isLoading.value = true;
      bool update = await employeeservice.changestatusemployee(id);
      if (update == true) {
        await fetchemployee();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeshift({
    required int employeeID,
    required int shiftID,
    int? assignBranchID,
    int? employeeshiftid,
  }) async {
    try {
      isLoading.value = true;

      bool update = await employeeservice.changeshift(
        EmployeeID: employeeID,
        ShiftID: shiftID,
        AssignBranchID: assignBranchID,
        employeeshiftid: employeeshiftid,
      );

      if (update) {
        // ✅ Refresh employee list
        await fetchemployee();
        Get.back();

        // ✅ Close bottom sheet after a short delay

        // 👈 Close the bottom sheet
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editsalary({
    required int basesalary,
    required int workday,
    required int salaryID,
  }) async {
    try {
      isLoading.value = true;
      bool update = await employeeservice.editsalary(
        baseSalary: basesalary,
        workday: workday,
        salaryID: salaryID,
      );
      if (update) {
        await fetchemployee();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> createemployeeshift({

    required int employeeid,
    required int shiftid,
    required int baseSalary,
    required int workday,
    required int salaryid,
    required int employeeshiftid,
  }) async{
    try{
isLoading.value = true;
bool created = await employeeservice.creteEmployeeShift(
  employeeid: employeeid, 
  shiftid: shiftid, 
  baseSalary: baseSalary, 
  workday: workday, 
  salaryid: salaryid, 
  employeeshiftid: employeeshiftid);
  if(created){
    await fetchemployee();
    Get.back();
  }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
