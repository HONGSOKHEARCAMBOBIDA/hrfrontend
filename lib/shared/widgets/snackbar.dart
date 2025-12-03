import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackbar {
  // Modern color scheme based on your primary color (0xFF1b3351)
  static const Color _primaryColor = Color(0xFF1b3351);
  static const Color _primaryLight = Color(0xFF2a4a7a);
  static const Color _primaryDark = Color(0xFF0d2039);
  
  // Complementary colors for different types
  static const Color _successColor = Color(0xFF10B981); // Emerald
  static const Color _successLight = Color(0xFF34D399);
  static const Color _warningColor = Color(0xFFF59E0B); // Amber
  static const Color _warningLight = Color(0xFFFBBF24);
  static const Color _errorColor = Color(0xFFEF4444); // Coral red
  static const Color _errorLight = Color(0xFFF87171);
  static const Color _infoColor = Color(0xFF3B82F6); // Sky blue
  static const Color _infoLight = Color(0xFF60A5FA);

  // Success Snackbar - Modern Gradient Style
  static void success({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      
      // Background container with gradient
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: _successColor.withOpacity(0.2),
          blurRadius: 12,
          spreadRadius: 1,
          offset: Offset(0, 4),
        ),
      ],
      
      // Custom background
      backgroundGradient: LinearGradient(
        colors: [
          _successColor,
          _successLight,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      
      // Icon with background
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
      
      // Title
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.3,
        ),
      ),
      
      // Message
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: Colors.white.withOpacity(0.9),
          height: 1.4,
        ),
      ),
    );
  }

  // Error Snackbar - Rich Red with Gradient
  static void error({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      
      // Shadow
      boxShadows: [
        BoxShadow(
          color: _errorColor.withOpacity(0.25),
          blurRadius: 15,
          spreadRadius: 1,
          offset: Offset(0, 4),
        ),
      ],
      
      // Background gradient
      backgroundGradient: LinearGradient(
        colors: [
          _errorColor,
          _errorLight,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      
      // Icon with circular background
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
      
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
      
      // Optional: Add a dismiss icon
      mainButton: TextButton(
        child: Icon(
          Icons.close,
          color: Colors.white.withOpacity(0.7),
          size: 18,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  // Warning Snackbar - Amber/Gold Theme
  static void warning({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      
      // Background with slight texture effect
      backgroundGradient: LinearGradient(
        colors: [
          _warningColor,
          _warningLight,
        ],
        stops: [0.3, 1.0],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      
      boxShadows: [
        BoxShadow(
          color: _warningColor.withOpacity(0.25),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
      
      icon: Icon(
        Icons.warning_amber_rounded,
        color: _primaryColor, // Use your blue for contrast
        size: 24,
      ),
      
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: _primaryColor, // Text in your blue for readability
        ),
      ),
      
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: _primaryColor.withOpacity(0.8),
        ),
      ),
    );
  }

  // Info Snackbar - Using your blue theme
  static void info({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
      
      // Gradient using your blue colors
      backgroundGradient: LinearGradient(
        colors: [
          _primaryColor,
          _primaryLight,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      
      boxShadows: [
        BoxShadow(
          color: _primaryColor.withOpacity(0.3),
          blurRadius: 15,
          spreadRadius: 1,
          offset: Offset(0, 6),
        ),
      ],
      
      // Icon with glass morphism effect
      icon: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
      
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  // Custom snackbar with action button
  static void withAction({
    required String title,
    required String message,
    required String actionText,
    required VoidCallback onAction,
    SnackbarType type = SnackbarType.info,
  }) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    
    switch (type) {
      case SnackbarType.success:
        backgroundColor = _successColor;
        textColor = Colors.white;
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        backgroundColor = _errorColor;
        textColor = Colors.white;
        icon = Icons.error_outline_rounded;
        break;
      case SnackbarType.warning:
        backgroundColor = _warningColor;
        textColor = _primaryColor;
        icon = Icons.warning_amber_rounded;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = _primaryColor;
        textColor = Colors.white;
        icon = Icons.info_outline_rounded;
        break;
    }
    
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 5),
      isDismissible: false,
      
      // Glass morphism effect
      backgroundGradient: LinearGradient(
        colors: [
          backgroundColor,
          backgroundColor.withOpacity(0.9),
        ],
      ),
      
      boxShadows: [
        BoxShadow(
          color: backgroundColor.withOpacity(0.3),
          blurRadius: 15,
          spreadRadius: 1,
        ),
      ],
      
      icon: Icon(
        icon,
        color: textColor,
        size: 24,
      ),
      
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
      
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: textColor.withOpacity(0.9),
        ),
      ),
      
      // Action button
      mainButton: TextButton(
        onPressed: onAction,
        child: Text(
          actionText,
          style: GoogleFonts.siemreap(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: textColor.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

enum SnackbarType {
  success,
  error,
  warning,
  info,
}

// Extension for easy usage
extension SnackbarExtension on GetInterface {
  void showSuccess(String title, String message) {
    CustomSnackbar.success(title: title, message: message);
  }
  
  void showError(String title, String message) {
    CustomSnackbar.error(title: title, message: message);
  }
  
  void showWarning(String title, String message) {
    CustomSnackbar.warning(title: title, message: message);
  }
  
  void showInfo(String title, String message) {
    CustomSnackbar.info(title: title, message: message);
  }
}

// Usage example:
// Get.showSuccess('ជោគជ័យ', 'ទិន្នន័យត្រូវបានរក្សាទុកដោយជោគជ័យ');
// Get.showError('បរាជ័យ', 'មិនអាចរក្សាទិន្នន័យបានទេ');
// CustomSnackbar.withAction(
//   title: 'ពិនិត្យឡើងវិញ',
//   message: 'តើអ្នកចង់លុបទិន្នន័យនេះទេ?',
//   actionText: 'លុប',
//   onAction: () => deleteItem(),
//   type: SnackbarType.warning,
// );