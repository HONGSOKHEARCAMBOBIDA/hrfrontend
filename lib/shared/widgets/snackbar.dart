import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; // <-- Import Google Fonts

class CustomSnackbar {
  // Success Snackbar
  static void success({required String title, required String message}) {
    Get.snackbar(
      '', // leave empty because we use titleText
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.successColor,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  // Error Snackbar
  static void error({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.lightGreyColor,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.error, color: TheColors.errorColor),
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: TheColors.errorColor,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 12,
          color: TheColors.errorColor,
        ),
      ),
    );
  }

  // Similarly, you can update info() and warning()...
}
