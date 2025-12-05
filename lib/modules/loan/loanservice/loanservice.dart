import 'package:flutter_application_10/data/models/loanmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class LoanService {
  final ApiProvider apiProvider = ApiProvider();

  Future<bool> createLoan({
    required int employeeId,
    required double loanAmount,
    required int currencyId,
  }) async {
    try {
      final body = {
        'employee_id': employeeId,
        'loan_amount': loanAmount,
        'currency_id': currencyId
      };

      final response = await apiProvider.post('addloan', body);

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "បង្កើតមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<List<Data>> getLoan({int? employeeId, int? branchId}) async {
    try {
      final params = <String, dynamic>{};
      if (employeeId != null) params['employee_id'] = employeeId;
      if (branchId != null) params['branch_id'] = branchId;

      final response = await apiProvider.get(
        'viewloan',
        queryParameters: params.isNotEmpty ? params : null,
      );

      if (response.statusCode == 200) {
        final model = LoanModel.fromJson(response.data);
        return model.data ?? [];
      } else {
        throw Exception("Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed: ${e.toString()}");
    }
  }

  Future<bool> updateLoan({
    required int loanId,
    required int employeeId,
    required double loanAmount,
    required double remainingBalance,
    required int currencyId,
  }) async {
    try {
      final body = {
        'employee_id': employeeId,
        'loan_amount': loanAmount,
        'remaining_balance': remainingBalance,
        'currency_id': currencyId
      };

      final response = await apiProvider.put('editloan/$loanId', body);

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
      return false;
    }
  }
}
