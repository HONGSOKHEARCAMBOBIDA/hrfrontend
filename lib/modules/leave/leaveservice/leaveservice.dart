import 'package:flutter_application_10/data/models/leavemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Leaveservice {
  final ApiProvider apiProvider = ApiProvider();

  Future<bool> createleave({
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
      final body = {
        'employee_shift_id': employeeshiftid,
        'is_permission': ispermission,
        'is_without_permission': iswithoutpermission,
        'is_weekend': isweekend,
        'start_date': startdate,
        'end_date': enddate,
        'leave_days': leaveday,
        'description': description,
        'approve_by_id': approvebyid,
      };

      final response = await apiProvider.post('addleave', body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to create leave");
      }
    } catch (e) {
      throw Exception("Failed: ${e.toString()}");
    }
  }

  Future<List<Data>> getleave({
    int? branchid,
    int? employeeid,
    String? employeename,
    int? ispermission,
    int? iswithoutpermission,
    int? isWeekend,
    int? status,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchid != null) params['branch_id'] = branchid;
      if (employeeid != null) params['employee_id'] = employeeid;
      if (employeename != null) params['employee_name'] = employeename;
      if (ispermission != null) params['permission'] = ispermission;
      if (iswithoutpermission != null) params['withoutpermission'] = iswithoutpermission;
      if (isWeekend != null) params['weekend'] = isWeekend;
      if (status != null) params['status'] = status;

      final response = await apiProvider.get(
        'viewleave',
        queryParameters: params.isNotEmpty ? params : null,
      );

      if (response.statusCode == 200) {
        final json = response.data;
        final model = LeaveModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed: ${e.toString()}");
    }
  }

  Future<bool> changestatusleave({required int leaveid}) async {
    try {
      final response = await apiProvider.put(
        'changestatusleave/$leaveid',
        {}, // or provide data if needed
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "កំហុស",
        message: "មានបញ្ហា: ${e.toString()}",
      );
      return false;
    }
  }

  Future<bool> updateleave({
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
      final body = {
        'employee_shift_id': employeeshiftid,
        'is_permission': ispermission,
        'is_without_permission': iswithoutpermission,
        'is_weekend': isweekend,
        'start_date': startdate,
        'end_date': enddate,
        'leave_days': leaveday,
        'description': description,
        'approve_by_id': approvebyid,
      };

      final response = await apiProvider.put('updateleave/$leaveid', body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to update leave");
      }
    } catch (e) {
      throw Exception("Failed: ${e.toString()}");
    }
  }
}
