import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/shftmodel.dart';
import 'package:flutter_application_10/shared/widgets/shift_selector.dart';


Future<void> showshiftbuttonsheet({
  required BuildContext context,
  required List<Data> shift,
  int? selectedShiftId,
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
        height: MediaQuery.of(context).size.height * 0.6,
        child: ShiftSelector(
          shift: shift,
          selectedshiftId: selectedShiftId,
          onSelected: onSelected,
        ),
      );
    },
  );
}
