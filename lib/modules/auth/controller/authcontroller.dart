import 'package:flutter_application_10/data/models/usermodel.dart' as myModel;
import 'package:flutter_application_10/data/models/userregistermodel.dart';
import 'package:flutter_application_10/data/models/userupdatemodel.dart';
import 'package:flutter_application_10/modules/auth/authservice/authservice.dart';
import 'package:flutter_application_10/modules/main/binding/mainbinding.dart';
import 'package:flutter_application_10/modules/main/mainview/a.dart';
import 'package:flutter_application_10/modules/main/mainview/mainview.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Authcontroller extends GetxController {
  final Authservice authservice = Authservice();
  var users = <myModel.Data>[].obs;
  var isLoading = false.obs;
  final GetStorage box = GetStorage();
  final RxString searchQuery = ''.obs;
  @override
  void onInit() {
    // Fetch all users first
    fetchUser();

    // Debounce search
    debounce(
      searchQuery, // Rx value to watch
      (_) => fetchUser(name: searchQuery.value), // Action to run
      time: const Duration(milliseconds: 200), // Wait 500ms after last input
    );

    super.onInit();
  }

  Future<void> fetchUser({
    int? branchID,
    int? roleId,
    int? is_active,
    String? name,
  }) async {
    try {
      isLoading.value = true;
      final result = await authservice.getuser(
        branchid: branchID,
        roleid: roleId,
        is_active: is_active,
        name: name,
      );
      users.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({required String phone, required String password}) async {
    isLoading.value = true;
    try {
      final response = await authservice.login(
        phone: phone,
        password: password,
      );

      if (response.token != null && response.token!.isNotEmpty) {
        await box.write('token', response.token); // <-- await is important
        CustomSnackbar.success(title: "ជោគជ័យ", message: "ចូលបានសម្រេច");
        Get.offAll(() => MainView(), binding: MainBinding());
      } else {
        CustomSnackbar.error(
          title: "បរាជ័យ",
          message: "លេខទូរសព្ទ ឬលេខសម្ងាត់ មិនត្រឹមត្រូវ",
        );
      }
    } catch (e) {
      print("Login Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(UserRegisterModel user) async {
    try {
      isLoading.value = true;

      bool isCreated = await authservice.register(user);

      if (isCreated) {
         await fetchUser();
        Get.back(result: true);
        CustomSnackbar.success(title: "ជោគជ័យ", message: "បង្កើតបានជោគជ័យ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false; // ❗ Fix: must be false, not true
    }
  }

  Future<void> updateuser(Userupdatemodel user) async {
    try {
      isLoading.value = true;
      bool isupdated = await authservice.updateuser(user);
      if (isupdated) {
        await fetchUser();
        Get.back(result: true);
        CustomSnackbar.success(title: "ជោគជ័យ", message: "កែប្រែបានជោគជ័យ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> changestatususer(int? id) async{
    try{
      isLoading.value = true;
      bool update = await authservice.changestatus(id: id);
      if(update){
        await fetchUser();

      }

    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
