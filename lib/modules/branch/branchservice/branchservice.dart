import 'package:flutter_application_10/data/models/branchmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Branchservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getbranch() async {
    try {
      final response = await apiProvider.get('viewbranch');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = BranchModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> createbranch({
    required String name,
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    try {
      final body = {
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'radius': radius,
      };
      final response = await apiProvider.post('addbranch', body);
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

  Future<bool> updatebranch({
    required String name,
    required double latitude,
    required double longitude,
    required int radius,
    required int branchID,
  }) async {
    try {
      final body = {
        'name': name,
        'latitube': latitude,
        'longitude': longitude,
        'radius': radius,
      };
      final response = await apiProvider.put("editbranch/${branchID}", body);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> changestatusbranch({required int branchid}) async {
    try {
      final response = await apiProvider.put(
        "changestatusbranch/${branchid}",
        branchid,
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
}
