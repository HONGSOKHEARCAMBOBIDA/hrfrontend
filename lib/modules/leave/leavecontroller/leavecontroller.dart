import 'package:flutter_application_10/data/models/leavemodel.dart';
import 'package:flutter_application_10/modules/leave/leaveservice/leaveservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Leavecontroller extends GetxController {
  final Leaveservice leaveservice = Leaveservice();

  var leave = <Data>[].obs;
  var isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    fetchleave();
    debounce(
      searchQuery,
      (_) => fetchleave(employeename: searchQuery.value),
      time: const Duration(milliseconds: 300),
    );
    super.onInit();
  }

  Future<void> fetchleave({
    int? branchid,
    int? employeeid,
    String? employeename,
    int? ispermission,
    int? iswithoutpermission,
    int? isWeekend,
    int? status,
  }) async {
    try {
      isLoading.value = true;
      final result = await leaveservice.getleave(
        branchid: branchid,
        employeeid: employeeid,
        employeename: employeename,
        ispermission: ispermission,
        iswithoutpermission: iswithoutpermission,
        isWeekend: isWeekend,
        status: status,
      );
      leave.assignAll(result);
    
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createleave({
    required int employeeshiftid,
    int? ispermission,
    int? iswithoutpermission,
    int? isweekend,
    required String startdate,
    required String enddate,
    required int leaveday,
    String? description,
    required int approvebyid,
  }) async {
    try {
      isLoading.value = true;
      bool iscreated = await leaveservice.createleave(
        employeeshiftid: employeeshiftid,
        ispermission: ispermission,
        iswithoutpermission: iswithoutpermission,
        isweekend: isweekend,
        startdate: startdate,
        enddate: enddate,
        leaveday: leaveday,
        description: description,
        approvebyid: approvebyid,
      );

      if (iscreated) {
        await fetchleave();
        Get.back();
        CustomSnackbar.success(
          title: "ជោគជ័យ",
          message: "បន្ថែមការឈប់សម្រាកបានជោគជ័យ",
        );
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateleave({
    required int leaveid,
    required int employeeshiftid,
    int? ispermission,
    int? iswithoutpermission,
    int? isweekend,
    required String startdate,
    required String enddate,
    required int leaveday,
    String? description,
    required int approvebyid,
  }) async {
    try {
      isLoading.value = true;
      bool isupdated = await leaveservice.updateleave(
        leaveid: leaveid,
        employeeshiftid: employeeshiftid,
        ispermission: ispermission,
        iswithoutpermission: iswithoutpermission,
        isweekend: isweekend,
        startdate: startdate,
        enddate: enddate,
        leaveday: leaveday,
        description: description,
        approvebyid: approvebyid,
      );

      if (isupdated) {
        await fetchleave();
        Get.back();

      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changstatusleave({required int leaveid}) async {
    try {
      isLoading.value = true;
      bool update = await leaveservice.changestatusleave(leaveid: leaveid);
      if (update) {
        await fetchleave();
    
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
