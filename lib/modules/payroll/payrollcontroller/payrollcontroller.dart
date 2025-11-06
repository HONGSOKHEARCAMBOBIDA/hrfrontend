import 'package:flutter_application_10/data/models/summarypayrollmodel.dart';
import 'package:flutter_application_10/modules/payroll/payrollservice/payrollservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Payrollcontroller extends GetxController {
  final Payrollservice payrollservice = Payrollservice();
  var payrolldraff = <Data>[].obs;
  var isLoading = false.obs;
  Future<void> fetchdraffpayroll({
    required int branchid,
    required int month,
  }) async {
    try {
      isLoading.value = true;
      final result = await payrollservice.getsummarypayroll(
        branchid: branchid,
        month: month,
      );
      payrolldraff.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
