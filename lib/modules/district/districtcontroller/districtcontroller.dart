import 'package:flutter/cupertino.dart';
import 'package:flutter_application_10/data/models/districtmodel.dart';
import 'package:flutter_application_10/modules/district/districtservice/districtservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Districtcontroller extends GetxController {
  final Districtservice districtservice = Districtservice();
  var district = <Data>[].obs;

  Future<void> fetchdistrict(int proviceid) async {
    try {
      final result = await districtservice.getdistrict(proviceid);
      district.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: e.toString());
    }
  }
}
