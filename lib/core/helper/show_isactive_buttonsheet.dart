import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/shared/widgets/isactive_selector.dart';

Future<void> showIsActiveSelectorSheet({
  required BuildContext context,
  int? selectedValue,          // 1 or 0
  required Function(int) onSelected,
}) {
  return showModalBottomSheet(
    backgroundColor: TheColors.bgColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3, // smaller, only 2 options
        child: IsActiveSelector(
          selectedValue: selectedValue,
          onSelected: onSelected,
        ),
      );
    },
  );
}
