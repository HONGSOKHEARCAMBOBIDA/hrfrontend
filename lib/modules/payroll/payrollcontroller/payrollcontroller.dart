import 'package:flutter_application_10/data/models/summarypayrollmodel.dart';
import 'package:flutter_application_10/modules/payroll/payrollservice/payrollservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Payrollcontroller extends GetxController {
  final Payrollservice payrollservice = Payrollservice();
  var payrolldraff = <Data>[].obs;
  var isLoading = false.obs;
  var isSubmitting = false.obs;

  Future<void> fetchdraffpayroll({
    required int branchid,
    required int month,
    required int currencyID,
  }) async {
    try {
      isLoading.value = true;
      final result = await payrollservice.getsummarypayroll(
        currencyID: currencyID,
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

  // Bulk payroll submission - SUBMIT ALL AT ONCE
  Future<void> submitAllPayrolls({
    required int month,
    required int branchId,
    required int currencyId,
    required Map<int, double> loanDeductions,
  }) async {
    try {
      isSubmitting.value = true;
      
      List<Map<String, dynamic>> payrollRequests = [];

      for (var payrollData in payrolldraff) {
        try {
          // Get the loan deduction for this specific payroll
          double loanDeduction = loanDeductions[payrollData.salaryId] ?? 0.0;
          
          // Calculate final net salary correctly
          double baseNetSalary = payrollData.netsalary ?? 0.0;
          
          // Add bonus if applicable
          final bonus = (payrollData.isBonusAttendanace == 1) 
              ? (payrollData.bonusAmount ?? 10) 
              : 0.0;
          
          // Calculate final net salary: base net salary + bonus - loan deduction
          double finalNetSalary = baseNetSalary + bonus - loanDeduction;
        
          double totalDeductions = (payrollData.totalDeductions ?? 0) + loanDeduction;

          // Create payroll object matching your Postman format
          Map<String, dynamic> payrollRequest = {
            'salary_id': payrollData.salaryId ?? 0,
            'payrollmonth': month,
            'notdeduction': payrollData.baseSalary?.toInt() ?? 0, // Using notdeduction
            'total_late': payrollData.totalLate ?? 0,
            'penaltylate': payrollData.penaltylate?.toInt() ?? 0,
            'total_earlyexit': payrollData.totalEarlyexit ?? 0,
            'totalexitpenalty': payrollData.totalexitpenalty?.toInt() ?? 0,
            'leave_with_permission': payrollData.leaveWithPermission ?? 0,
            'penalty_leave_with_permission': payrollData.penaltyLeaveWithPermission ?? 0.0,
            'leave_without_permission': payrollData.leaveWithoutPermission ?? 0,
            'penalty_leave_without_permission': payrollData.penaltyLeaveWithoutPermission ?? 0.0,
            'leave_weekend': payrollData.leaveWeekend ?? 0,
            'penalty_leave_weekend': payrollData.penaltyLeaveWeekend?.toInt() ?? 0,
            'loan_id': payrollData.loanId ?? 0,
            'loanDeduction': loanDeduction, // Using loanDeduction
            'is_attendance_bonus': payrollData.isBonusAttendanace ?? 0,
            'bonus_type': payrollData.isBonusAttendanace == 1 ? "Attendance Bonus" : "",
            'bonus_amount': payrollData.isBonusAttendanace == 1 ? (payrollData.bonusAmount?.toDouble() ?? 0.0) : 0.0,
            'totalDeductions':totalDeductions,// Using totalDeductions
            'netsalary': finalNetSalary,
            'branch_id': branchId,
            'currency_id': currencyId
          };

          payrollRequests.add(payrollRequest);

        } catch (e) {
         
          CustomSnackbar.error(
            title: "កំហុស", 
            message: "មិនអាចបង្កើតទិន្នន័យសម្រាប់ ${payrollData.nameKh} បានទេ"
          );
        }
      }

      if (payrollRequests.isNotEmpty) {
        bool isCreated = await payrollservice.createBulkPayroll(payrollRequests);

        if (isCreated) {
          payrolldraff.clear();
          loanDeductions.clear();
          CustomSnackbar.success(
            title: "ជោគជ័យ",
            message: "បានបញ្ជូនប្រាក់ខែ ${payrollRequests.length} បានជោគជ័យ",
          );
        } else {
          CustomSnackbar.error(
            title: "បញ្ហា",
            message: "មិនអាចបញ្ជូនប្រាក់ខែបានទេ",
          );
        }
      } else {
        CustomSnackbar.error(
          title: "ទិន្នន័យ",
          message: "មិនមានទិន្នន័យប្រាក់ខែដេីម្បីបញ្ជូនទេ",
        );
      }

    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}