import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        decoration: BoxDecoration(
          color: TheColors.bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GetBuilder<MainController>(
              id: 'bottom_navigation_bar',
              builder: (controller) {
                return GNav(
                  // Colors
                  backgroundColor: TheColors.bgColor,

                  activeColor: Colors.white, // Active icon/text color
                  tabBackgroundColor: TheColors.primaryColor, // Active tab bg
                  tabBorderRadius: 12,
                  tabMargin: const EdgeInsets.symmetric(vertical: 4),
                  
                  // Padding & Spacing
                  gap: 8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  
                  // Text style
                  textStyle: GoogleFonts.siemreap(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  iconSize: 22,
                  
                  // Animation
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  haptic: true, // Haptic feedback
                  
                  // State
                  selectedIndex: controller.selectedIndex,
                  onTabChange: controller.onItemTapped,
                  
                  tabs: [
                    GButton(
                      icon: Icons.home_outlined,
                      iconActiveColor: Colors.white,
                      text: "អ្នកកាន់ប្រព័ន្ធ",
                      textColor: Colors.white,
                    ),
                    GButton(
                      icon: Icons.people_outline,
                      iconActiveColor: Colors.white,
                      text: "ធនធានមនុស្ស",
                      textColor: Colors.white,
                    ),
                    GButton(
                      icon: Icons.badge_outlined,
                      iconActiveColor: Colors.white,
                      text: "បុគ្គលិក",
                      textColor: Colors.white,
                    ),
                    
                    // Optional: Add more tabs if needed
                    // GButton(
                    //   icon: Icons.payments_outlined,
                    //   iconActiveColor: Colors.white,
                    //   text: "ប្រាក់ខែ",
                    //   textColor: Colors.white,
                    // ),
                    // GButton(
                    //   icon: Icons.settings_outlined,
                    //   iconActiveColor: Colors.white,
                    //   text: "ការកំណត់",
                    //   textColor: Colors.white,
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}