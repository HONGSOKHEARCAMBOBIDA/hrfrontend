import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_10/data/models/rolemodel.dart';
import 'package:flutter_application_10/data/models/rolepermission.dart' as mymodel;
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/modules/role/roleview/rolepermissionfordelete.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Roleservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getrole() async {
    try {
      final response = await apiProvider.get('viewrole');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = RoleModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> createrole(Data rolemodel) async {
    try {
      final response = await apiProvider.post('addrole', rolemodel.toJson());
      if (response.statusCode == 200) {
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

  Future<bool> updaterole(Data rolemodel) async {
    try {
      final response = await apiProvider.put(
        "editrole/${rolemodel.id}",
        rolemodel.toJson(),
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

  Future<bool> changestatusrole(int? id) async {
    try {
      final response = await apiProvider.put("changestatusrole/${id}", id);
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

  Future<List<mymodel.Data>> getroleassignpermission(int roleid) async {
  try {
    final response = await apiProvider.get("viewrolehaspermission/${roleid}");

    if (response.statusCode == 200) {
        final json = response.data;
        final model = mymodel.RolePermissionModel.fromJson(json);
        return model.data ?? [];
    } else {
      throw Exception('Failed to load roles: ${response.statusCode}');
    }
  } on DioException catch (e) {
    throw Exception('Failed: ${e.toString()}');
  } catch (e) {
    throw Exception('Failed to load roles: ${e.toString()}');
  }

}
}
