import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/currencypairmodel.dart';
import 'package:flutter_application_10/shared/widgets/currencypairselector.dart';

Future<void> showcurrencypair({
  required BuildContext context,
  required List<Data> currencypair,
  int? selectedCurrencypair,
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
        child: Currencypairselector(
          currencypair: currencypair,
          selectedcurrencypair: selectedCurrencypair,
          onSelected: onSelected,
        ),
      );
    },
  );
}
