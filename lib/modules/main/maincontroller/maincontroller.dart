import 'package:flutter/material.dart';
import 'package:flutter_application_10/modules/attendance/view/createattendanceview.dart';
import 'package:flutter_application_10/modules/auth/binding/authbinding.dart';
import 'package:flutter_application_10/modules/auth/view/loginview.dart';
import 'package:flutter_application_10/modules/main/mainview/a.dart';
import 'package:flutter_application_10/modules/main/mainview/b.dart';
import 'package:flutter_application_10/modules/main/mainview/c.dart';
import 'package:flutter_application_10/modules/main/mainview/d.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex =
      1; // Tracks the selected index for the bottom navigation bar
  var lstscreen = <Widget>[]; // List of screens for the IndexedStack

  final box = GetStorage(); // Local storage for token and role ID

  @override
  void onInit() {
    super.onInit();

    // Initialize the list of screens
    lstscreen = [
      a(), // Screen for warehouse
      Createattendanceview(), // Screen for check time
      c(), // Screen for items
      d(), // Screen for users
    ];
  }

  // Handle navigation item taps
  void onItemTapped(int index) {
    selectedIndex = index; // Update the selected index
    update(['index_stack', 'bottom_navigation_bar']); // Trigger UI update
  }

  // Logout the user
  void logout() async {
    await box.remove("token"); // Clear the stored token

    Get.offAll(() => LoginView(), binding: Authbinding());
  }
}
