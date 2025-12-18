import 'package:flutter/material.dart';
import 'package:flutter_application_10/modules/attendance/view/createattendanceview.dart';
import 'package:flutter_application_10/modules/auth/binding/authbinding.dart';
import 'package:flutter_application_10/modules/auth/view/loginview.dart';
import 'package:flutter_application_10/modules/main/mainview/a.dart';
import 'package:flutter_application_10/modules/main/mainview/c.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainController extends GetxController {
  var selectedIndex = 0; // Tracks the selected index for the bottom navigation bar
  var lstscreen = <Widget>[]; // List of screens for the IndexedStack

  final box = GetStorage(); // Local storage for token and role ID

@override
void onInit() {
  super.onInit();

  lstscreen = [];

  if (hasPart('Admin Part')) {
    lstscreen.add(a());
  }

  if (hasPart('HR Part')) {
    lstscreen.add(Createattendanceview());
  }

  if (hasPart('Staff Part')) {
    lstscreen.add(c());
  }

  // fallback safety
  if (lstscreen.isEmpty) {
    lstscreen.add(
      Center(child: Text("គ្មានសិទ្ធិប្រើប្រាស់")),
    );
  }
   
}
List<GButton> getTabs() {
  final tabs = <GButton>[];

  if (hasPart('Admin Part')) {
    tabs.add(
      GButton(
        icon: Icons.home_outlined,
        text: "អ្នកកាន់ប្រព័ន្ធ",
      ),
    );
  }

  if (hasPart('HR Part')) {
    tabs.add(
      GButton(
        icon: Icons.people_outline,
        text: "ធនធានមនុស្ស",
      ),
    );
  }

  if (hasPart('Staff Part')) {
    tabs.add(
      GButton(
        icon: Icons.badge_outlined,
        text: "បុគ្គលិក",
      ),
    );
  }

  return tabs;
}

  // Handle navigation item taps
void onItemTapped(int index) {
  if (index >= lstscreen.length) return;
  selectedIndex = index;
  update(['index_stack', 'bottom_navigation_bar']);
}
  // Logout the user
  void logout() async {
    await box.remove("token"); // Clear the stored token
    await box.remove("part");
    Get.offAll(() => LoginView(), binding: Authbinding());
  }

  bool hasPart(String partName) {
  final List<String> partNames =
      List<String>.from(box.read('part') ?? []);
  return partNames.contains(partName);
}

}
