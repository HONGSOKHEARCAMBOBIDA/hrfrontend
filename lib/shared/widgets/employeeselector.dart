import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart';

class Employeeselector extends StatefulWidget {
  final List<Data> employee;
  final int? selectEmployeeId;
  final Function(int) onSelected;

  const Employeeselector({
    Key? key,
    required this.employee,
    this.selectEmployeeId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<Employeeselector> createState() => _BranchSelectorState();
}

class _BranchSelectorState extends State<Employeeselector> {
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
              Text('ជ្រើសរើសបុគ្គលិក', style: TextStyles.siemreap(context)),
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
                children: widget.employee.map((employees) {
                  final isSelected = employees.id == widget.selectEmployeeId;
                  return ChoiceChip(
                    label: Text(
                      employees.name ?? '',
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    selected: isSelected,
                    backgroundColor: TheColors.lightGreyColor,
                    selectedColor: TheColors.orange,
                    side: BorderSide.none,
                    onSelected: (_) {
                      widget.onSelected(employees.id!);
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
