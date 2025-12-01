import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
   final ValueChanged<String>? onChanged;
    final bool readOnly;

  const CustomTextField({
    Key? key,
    this.readOnly=false,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
     this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,

      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: TheColors.errorColor),
        hintText: hintText,
        
        hintStyle: TextStyles.siemreap(context,fontSize: 11,color: TheColors.gray),
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: TheColors.orange, width: 0.5), // Primary Blue
          
        ),
    
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: TheColors.errorColor, width: 0.5), // Primary Blue
  ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      ),
      style: TextStyles.siemreap(context,fontSize: 12),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'សូមបំពេញ';
            }
            return null;
          },
            onChanged: onChanged,
    );
  }
}