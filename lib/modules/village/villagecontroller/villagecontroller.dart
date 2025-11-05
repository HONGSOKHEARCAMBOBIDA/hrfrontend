import 'package:flutter_application_10/data/models/villagemodel.dart';
import 'package:flutter_application_10/modules/village/villageservice/villageservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Villagecontroller extends GetxController {
  final Villageservice villageservice = Villageservice();
  var village = <Data>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetvillage($communceid) async {
    try {
      final result = await villageservice.getvillage($communceid);
      village.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(
        title: "ខុសប្រក្រតី",
        message: "ទិន្ន័យទាញមិនបាន ${e}",
      );
    }
  }
}
