import 'package:flutter_application_10/data/models/attendancemodel.dart'
    as mymodel;
import 'package:flutter_application_10/data/models/employeeshiftmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Attendanceservice {
  final ApiProvider apiProvider = ApiProvider();

  Future<bool> checkin({
    required int employeeshiftid,
    required double latitube,
    required double longitude,
  }) async {
    try {
      final body = {
        'employee_shift_id': employeeshiftid,
        'latitude': latitube,
        'longitude': longitude,
      };
      final response = await apiProvider.post("checkin", body);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "បង្កេីតមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> checkout({
    required int employee_shiftid,
    required double latitube,
    required double longitude,
  }) async {
    try {
      final body = {
        'employee_shift_id': employee_shiftid,
        'latitude': latitube,
        'longitude': longitude,
      };
      // ✅ Correct endpoint for checkout
      final response = await apiProvider.post("checkout", body);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "ចេញការងារមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<List<Data>> getemployeeshift() async {
    try {
      final response = await apiProvider.get('viewemployeeshift');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = EmployeeShiftModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<List<mymodel.Data>> getattendance({
    int? branchID,
    int? islate,
    int? isLeftEarly,
    String? name,
    String? startdate,
    String? enddate,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchID != null) params['branch_id'] = branchID;
      if (islate != null) params['islate'] = islate;
      if (isLeftEarly != null) params['isleftearly'] = isLeftEarly;
      if (name != null) params['name'] = name;
      if (startdate != null) params['start_date'] = startdate;
      if (enddate != null) params['end_date'] = enddate;
      final response = await apiProvider.get(
        'viewattendance',
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final model = mymodel.AttendanceModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }
}
