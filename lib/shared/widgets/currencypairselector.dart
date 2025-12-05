import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/currencypairmodel.dart';


class Currencypairselector extends StatelessWidget {
  final List<Data> currencypair;
  final int? selectedcurrencypair;
  final Function(int) onSelected;

  const Currencypairselector({
    Key? key,
    required this.currencypair,
    this.selectedcurrencypair,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ជ្រើសរើសការប្ដូរប្រាក់', style: TextStyles.siemreap(context)),
              IconButton(
                icon: const Icon(Icons.close, color: TheColors.errorColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 5,
                runSpacing: 8,
                children: currencypair.map((currencypair) {
                  final isSelected = currencypair.id == selectedcurrencypair;
                  return ChoiceChip(
                    label: Text(
                      "${currencypair.baseCurrencyName}"+" -> "+"${currencypair.targetCurrencyName}",
                     
                      style: TextStyles.siemreap(context,fontSize: 12,color: isSelected ? TheColors.bgColor : TheColors.black)
                    ),
                    selected: isSelected,
                    backgroundColor: TheColors.warningColor,
                    selectedColor: TheColors.orange,
                      surfaceTintColor: Colors.transparent,
                      selectedShadowColor: TheColors.orange,
                    side: BorderSide(color: TheColors.warningColor,width: 0.3),
                    onSelected: (_) {
                      
                      onSelected(currencypair.id!);
                      Navigator.pop(context);
                       FocusScope.of(context).unfocus();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
