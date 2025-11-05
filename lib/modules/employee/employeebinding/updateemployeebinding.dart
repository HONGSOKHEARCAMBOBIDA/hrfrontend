import 'package:flutter_application_10/modules/employee/employeebinding/employeebinding.dart';
import 'package:get/get.dart';
import 'package:flutter_application_10/modules/branch/brandbinding/branchbinding.dart';
import 'package:flutter_application_10/modules/communce/communcebinding/communcebinding.dart';
import 'package:flutter_application_10/modules/district/districtbinding/districtbinding.dart';
import 'package:flutter_application_10/modules/province/provincebinding/provincebinding.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/village/villagebinding/villagebinding.dart';
class Updateemployeebinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Employeebinding().dependencies();
    Provincebinding().dependencies();
    Districtbinding().dependencies();
    Communcebinding().dependencies();
    Villagebinding().dependencies();
    Rolebinding().dependencies();
    Branchbinding().dependencies();

  }
}