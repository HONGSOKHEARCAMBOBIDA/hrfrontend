import 'package:flutter_application_10/data/models/shftmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Shiftservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getshift(int? branchid) async {
    try {
      final response = await apiProvider.get('viewshiftbybranchid/${branchid}');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = ShiftModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<List<Data>> getallshift() async {
    try {
      final response = await apiProvider.get('viewshift');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = ShiftModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> CreateShift({
    required String name,
    required String start_time,
    required String end_time,
    required int branchid,
  }) async {
    try {
      final body = {
        'name': name,
        'start_time': start_time,
        'end_time': end_time,
        'branch_id': branchid,
      };
      final response = await apiProvider.post("shift", body);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "បង្កេីតមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
      return false;
    }
  }
}
