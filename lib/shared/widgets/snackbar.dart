import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:get/get.dart';

//import 'package:sample_flutter_configuration/widgets/the_colors.dart'; // Import your color file

class CustomSnackbar {
  // Success Snackbar
  static void success({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.successColor, // Using your stored color
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  // Error Snackbar
  static void error({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.lightGreyColor, // Using your stored color
      colorText: TheColors.errorColor,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.error, color: TheColors.errorColor),
    );
  }

  // Info Snackbar
  static void info({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.infoColor, // Using your stored color
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  // Warning Snackbar
  static void warning({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.warningColor, // Using your stored color
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }
}