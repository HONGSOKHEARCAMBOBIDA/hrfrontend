import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class EditSalaryView extends StatefulWidget {
  final int salaryID;

  const EditSalaryView({super.key, required this.salaryID});

  @override
  State<EditSalaryView> createState() => _EditSalaryViewState();
}

class _EditSalaryViewState extends State<EditSalaryView> {
  final Employeecontroller employeeController = Get.find<Employeecontroller>();
  final TextEditingController baseSalaryController = TextEditingController();
  final TextEditingController workDayController = TextEditingController();

  @override
  void dispose() {
    baseSalaryController.dispose();
    workDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Text(
                      "ប្រាក់ខែគោល",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: baseSalaryController,
                      hintText: "300",
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "ចំនួនថ្ងៃធ្វើការ",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: workDayController,
                      hintText: "30",
                      prefixIcon: Icons.lock_clock_rounded,
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: "កែប្រែ",
                      onPressed: () async {
                        // Convert text to int, provide a fallback value if parsing fails
                        final int? baseSalary = int.tryParse(
                          baseSalaryController.text.trim(),
                        );
                        final int? workDays = int.tryParse(
                          workDayController.text.trim(),
                        );

                        if (baseSalary == null || workDays == null) {
                          CustomSnackbar.error(
                            title: "មានបញ្ហា",
                            message: "សូមបញ្ចូលលេខត្រឹមត្រូវ",
                          );
                          return;
                        }

                        await employeeController.editsalary(
                          basesalary: baseSalary,
                          workday: workDays,
                          salaryID: widget.salaryID,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
