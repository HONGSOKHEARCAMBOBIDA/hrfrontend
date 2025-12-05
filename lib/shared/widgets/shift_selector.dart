import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/shftmodel.dart';


class ShiftSelector extends StatelessWidget {
  final List<Data> shift;
  final int? selectedshiftId;
  final Function(int) onSelected;

  const ShiftSelector({
    Key? key,
    required this.shift,
    this.selectedshiftId,
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
              Text('ជ្រើសរើសវេនការងារ', style: TextStyles.siemreap(context)),
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
                children: shift.map((shifts) {
                  final isSelected = shifts.id == selectedshiftId;
                  return ChoiceChip(
                    label: Text("${shifts.name}: ${shifts.startTime}-${shifts.endTime}",style: TextStyles.siemreap(context,fontSize: 12),),
                    selected: isSelected,
                    backgroundColor: TheColors.lightGreyColor,
                    selectedColor: TheColors.orange,
                    side: BorderSide(color: TheColors.warningColor,width: 0.3),
                    onSelected: (_) {
                      onSelected(shifts.id!);
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
