import 'package:flutter_application_10/data/models/communcemodel.dart';
import 'package:flutter_application_10/modules/communce/communceservice/communceservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Communcecontroller extends GetxController {
  final Communceservice communceservice = Communceservice();
  var communce = <Data>[].obs;

  Future<void> fetchcommunce(int district_id) async {
    try {
      final result = await communceservice.getcommunce(district_id);
      communce.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: e.toString());
    }
  }
}
