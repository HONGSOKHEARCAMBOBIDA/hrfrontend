import 'package:flutter_application_10/data/models/loanmodel.dart';
import 'package:flutter_application_10/modules/loan/loanservice/loanservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class LoanController extends GetxController {
  final LoanService loanService = LoanService();

  var loan = <Data>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchLoan(); // Fetch all loans on initialization
    super.onInit();
  }

  Future<void> fetchLoan({int? employeeId, int? branchId}) async {
    try {
      isLoading.value = true;
      final response = await loanService.getLoan(
        employeeId: employeeId,
        branchId: branchId,
      );

      // Make sure response contains data and update observable list
      loan.assignAll(response);
      
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createLoan({
    required int employeeId,
    required double loanAmount,
    required int currencyId,
  }) async {
    try {
      isLoading.value = true;
      bool isCreated = await loanService.createLoan(
        employeeId: employeeId,
        loanAmount: loanAmount,
        currencyId: currencyId
      );

      if (isCreated) {
        await fetchLoan();
        Get.back();
        CustomSnackbar.success(title: "ជោគជ័យ", message: "បានបង្កើតឥណទានថ្មី");
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateLoan({
    required int loanId,
    required int employeeId,
    required double loanAmount,
    required double remainingBalance,
    required int currencyID
  }) async {
    try {
      isLoading.value = true;
      bool isUpdated = await loanService.updateLoan(
        loanId: loanId,
        employeeId: employeeId,
        loanAmount: loanAmount,
        remainingBalance: remainingBalance,
        currencyId: currencyID
      );

      if (isUpdated) {
        await fetchLoan();
        Get.back();
        CustomSnackbar.success(
          title: "ជោគជ័យ",
          message: "បានធ្វើបច្ចុប្បន្នភាពឥណទាន",
        );
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
