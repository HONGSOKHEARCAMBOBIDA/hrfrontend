import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/currencymodel.dart';

class Currencyselector extends StatefulWidget {
  final List<Data> currency;
  final int? selectedCurrencyId;
  final Function(int) onSelected;

  const Currencyselector({
    Key? key,
    required this.currency,
    this.selectedCurrencyId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<Currencyselector> createState() => _BranchSelectorState();
}

class _BranchSelectorState extends State<Currencyselector> {
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
              Text('ជ្រើសរើសរូបិយប័ណ្ណ', style: TextStyles.siemreap(context)),
              IconButton(
                icon: const Icon(Icons.close),
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
                children: widget.currency.map((currency) {
                  final isSelected = currency.id == widget.selectedCurrencyId;
                  return ChoiceChip(
                    
                    label: Text(
                      currency.name ?? '',
                       style: TextStyles.siemreap(context,fontSize: 12,color: isSelected ? TheColors.bgColor : TheColors.black)
                    ),
                    
                    selected: isSelected,
                    backgroundColor: TheColors.warningColor,
                    selectedColor: TheColors.orange,
                     side: BorderSide(color: TheColors.warningColor,width: 0.3),
                    onSelected: (_) {
                      widget.onSelected(currency.id!);
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
