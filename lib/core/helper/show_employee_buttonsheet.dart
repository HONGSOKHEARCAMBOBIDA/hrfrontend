import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';

import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/shared/widgets/branch_selector.dart';
import 'package:flutter_application_10/shared/widgets/employeeselector.dart';

Future<void> showemployeebuttonsheet({
  required BuildContext context,
  required List<Data> employee,
  int? selectEmployeeId,
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
        child: Employeeselector(
          employee: employee,
          selectEmployeeId: selectEmployeeId,
          onSelected: onSelected,
        ),
      );
    },
  );
}
