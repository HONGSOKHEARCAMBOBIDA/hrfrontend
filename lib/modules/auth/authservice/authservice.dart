import 'package:flutter_application_10/core/helper/gettoken.dart';
import 'package:flutter_application_10/data/models/loginmodel.dart';
import 'package:flutter_application_10/data/models/usermodel.dart';
import 'package:flutter_application_10/data/models/userregistermodel.dart';
import 'package:flutter_application_10/data/models/userupdatemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Authservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getuser({
    int? branchid,
    int? roleid,
    int? is_active,
    String? name,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchid != null) params['branch_id'] = branchid;
      if (roleid != null) params['role_id'] = roleid;
      if (is_active != null) params['is_active'] = is_active;
      if (name != null && name.isNotEmpty) params['name'] = name;
      final response = await apiProvider.get(
        'viewuser1',
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final model = UserModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<LoginModel> login({
    required String phone,
    required String password,
  }) async {
    try {
      final body = {'contact': phone, 'password': password};

      final response = await apiProvider.post("login", body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.data}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<bool> register(UserRegisterModel user) async {
    try {
      final token = getToken();
      if (token == null) {
        CustomSnackbar.error(
          title: "មិនអាចចូលបាន",
          message: "សូមធ្វើការ Login",
        );
        return false;
      }

      final response = await apiProvider.post('register', user.toJson());
      if (response.statusCode == 201) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "រក្សាទុកមិនបានទេ");
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

  Future<bool> updateuser(Userupdatemodel user) async {
    try {
      final response = await apiProvider.put(
        'updateuser/${user.ID}',
        user.toJson(),
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

  Future<bool> changestatus({int? id}) async {
    try {
      final response = await apiProvider.put('chnagestatususer/${id}', id);
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
