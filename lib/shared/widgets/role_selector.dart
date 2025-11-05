import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/rolemodel.dart';


class RoleSelector extends StatefulWidget {
  final List<Data> role;
  final int? selectedRoleId;
  final Function(int) onSelected;

  const RoleSelector({
    Key? key,
    required this.role,
    this.selectedRoleId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
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
              Text('ជ្រើសរើសតួនាទី', style: TextStyles.siemreap(context)),
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
                children: widget.role.map((roles) {
                  final isSelected = roles.id == widget.selectedRoleId;
                  return ChoiceChip(
                    label: Text(
                      roles.displayName ?? '',
                       style: TextStyles.siemreap(context,fontSize: 12)
                    ),
                    selected: isSelected,
                    backgroundColor: TheColors.lightGreyColor,
                    selectedColor: TheColors.orange,
                    side: BorderSide.none,
                    onSelected: (_) {
                      widget.onSelected(roles.id!);
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
