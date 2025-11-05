import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; // ✅ Import GNav

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      body: GetBuilder<MainController>(
        id: 'index_stack',
        builder: (controller) {
          return IndexedStack(
            index: controller.selectedIndex,
            children: controller.lstscreen,
          );
        },
      ),
      bottomNavigationBar: Container(
        color: TheColors.bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: GetBuilder<MainController>(
          id: 'bottom_navigation_bar',
          builder: (controller) {
            return GNav(
              gap: 8,
              backgroundColor: TheColors.bgColor,
              color: Colors.grey[600],
              activeColor: Colors.white,
              tabBackgroundColor: TheColors.errorColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              selectedIndex: controller.selectedIndex,
              onTabChange: controller.onItemTapped,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Admin",
                ),
                GButton(
                  icon: Icons.build,
                  text: "HR",
                ),
                GButton(
                  icon: Icons.swap_horiz,
                  text: "Accounting",
                ),
                GButton(
                  icon: Icons.settings,
                  text: "Staff",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
