import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/branchmodel.dart';

class BranchSelector extends StatefulWidget {
  final List<Data> branch;
  final int? selectedBranchId;
  final Function(int) onSelected;

  const BranchSelector({
    Key? key,
    required this.branch,
    this.selectedBranchId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<BranchSelector> createState() => _BranchSelectorState();
}

class _BranchSelectorState extends State<BranchSelector> {
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
              Text('ជ្រើសរើសសាខា', style: TextStyles.siemreap(context)),
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
                children: widget.branch.map((branchs) {
                  final isSelected = branchs.id == widget.selectedBranchId;
                  return ChoiceChip(
                    label: Text(
                      branchs.name ?? '',
                       style: TextStyles.siemreap(context,fontSize: 12,color: isSelected ? TheColors.bgColor : TheColors.black)
                    ),
                    selected: isSelected,
                    backgroundColor: TheColors.lightGreyColor,
                    selectedColor: TheColors.orange,
                    side: BorderSide.none,
                    onSelected: (_) {
                      widget.onSelected(branchs.id!);
                      Navigator.pop(context);
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
