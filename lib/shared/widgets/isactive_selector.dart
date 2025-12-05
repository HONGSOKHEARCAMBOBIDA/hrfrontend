import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';

class IsActiveSelector extends StatelessWidget {
  final int? selectedValue; // 1 or 0
  final Function(int) onSelected;

  const IsActiveSelector({
    Key? key,
    this.selectedValue,
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
              Text('ជ្រើសរើសស្ថានភាព', style: TextStyles.siemreap(context)),
              IconButton(
                icon: const Icon(Icons.close, color: TheColors.errorColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5,
            runSpacing: 8,
            children: [
              _buildChip(
                context,
                label: 'សកម្ម (1)',
                value: 1,
              ),
              _buildChip(
                context,
                label: 'អសកម្ម (0)',
                value: 0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context,
      {required String label, required int value}) {
    final isSelected = selectedValue == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyles.siemreap(context, fontSize: 12),
      ),
      selected: isSelected,
      backgroundColor: TheColors.lightGreyColor,
      selectedColor: TheColors.orange,
       side: BorderSide(color: TheColors.warningColor,width: 0.3),
      onSelected: (_) {
        onSelected(value);
        Navigator.pop(context);
         FocusScope.of(context).unfocus();
      },
    );
  }
}
