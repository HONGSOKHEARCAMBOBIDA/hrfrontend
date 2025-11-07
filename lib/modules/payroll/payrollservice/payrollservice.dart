import 'package:flutter_application_10/data/models/payrollrequestmodel.dart';
import 'package:flutter_application_10/data/models/summarypayrollmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Payrollservice {
  final ApiProvider apiProvider = ApiProvider();
  
  Future<List<Data>> getsummarypayroll({
    required int branchid,
    required int month,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchid != null) params['branch_id'] = branchid;
      if (month != null) params['month'] = month;
      final respone = await apiProvider.get(
        'viewpayroll',
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (respone.statusCode == 200) {
        final json = respone.data;
        final model = SummaryPayRollModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed: ${respone.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Bulk payroll creation - send all at once
  Future<bool> createBulkPayroll(List<Map<String, dynamic>> payrolls) async {
    try {
  
      
      final response = await apiProvider.post('addpayroll', payrolls);
      
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(
          title: "បរាជ័យ", 
          message: "រក្សាទុកមិនបានទេ: ${response.statusCode}"
        );
        return false;
      }
    } catch (e) {
      print('Exception in createBulkPayroll: $e');
      CustomSnackbar.error(
        title: "កំហុស", 
        message: "កំហុសក្នុងការតភ្ជាប់: $e"
      );
      return false;
    }
  }

  // Keep the single payroll method for backward compatibility
  Future<bool> createpayroll({
    required int SalaryID,
    required int PayrollMonth,
    required int GrossSalary,
    int? TotalLate,
    int? LatePenalty,
    int? ToalEarlyexit,
    int? TotalExitpenalty,
    int? LeaveWithPermission,
    double? PeanaltyLeaveWithPermission,
    int? LeaveWithoutPermission,
    double? PenaltyLeaveWithoutPermission,
    int? LeaveWeekend,
    int? PenaltyLeaveWeekend,
    int? LoanID,
    double? LoanDeduction,
    int? IsAttendanceBonus,
    String? BonusType,
    double? BonusAmount,
    double? TotalDeduction,
    double? NetSalary,
    required int BranchId,
  }) async {
    try {
      final payrolls = [
        {
          'salary_id': SalaryID,
          'payrollmonth': PayrollMonth,
          'notdeduction': GrossSalary, // Changed back to notdeduction
          'total_late': TotalLate ?? 0,
          'penaltylate': LatePenalty ?? 0,
          'total_earlyexit': ToalEarlyexit ?? 0,
          'totalexitpenalty': TotalExitpenalty ?? 0,
          'leave_with_permission': LeaveWithPermission ?? 0,
          'penalty_leave_with_permission': PeanaltyLeaveWithPermission ?? 0.0,
          'leave_without_permission': LeaveWithoutPermission ?? 0,
          'penalty_leave_without_permission': PenaltyLeaveWithoutPermission ?? 0.0,
          'leave_weekend': LeaveWeekend ?? 0,
          'penalty_leave_weekend': PenaltyLeaveWeekend ?? 0,
          'loan_id': LoanID ?? 0,
          'loanDeduction': LoanDeduction ?? 0.0, // Changed to loanDeduction
          'is_attendance_bonus': IsAttendanceBonus ?? 0,
          'bonus_type': BonusType ?? "",
          'bonus_amount': BonusAmount ?? 0.0,
          'totalDeductions': TotalDeduction ?? 0.0, // Changed to totalDeductions
          'netsalary': NetSalary ?? 0.0,
          'branch_id': BranchId,
        }
      ];
      
      return await createBulkPayroll(payrolls);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}