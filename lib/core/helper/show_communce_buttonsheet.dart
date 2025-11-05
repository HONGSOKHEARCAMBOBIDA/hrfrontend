import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/communcemodel.dart';
import 'package:flutter_application_10/shared/widgets/communce_selector.dart';
import 'package:flutter_application_10/shared/widgets/province_selector.dart';

Future<void> showCommunceSelectorSheet({
  required BuildContext context,
  required List<Data> communce,
  int? selectedCommunce,
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
        child: CommunceSelector(
          communce: communce,
          selecteCommunceId: selectedCommunce,
          onSelected: onSelected,
        ),
      );
    },
  );
}
