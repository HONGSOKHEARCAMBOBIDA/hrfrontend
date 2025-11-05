import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/loan/loancontroller/loancontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class CreateLoanView extends StatefulWidget {
  const CreateLoanView({super.key});

  @override
  State<CreateLoanView> createState() => _CreateLoanViewState();
}

class _CreateLoanViewState extends State<CreateLoanView> {
  final loanController = Get.find<LoanController>();
  final branchController = Get.find<Branchcontroller>();
  final employeeController = Get.find<Employeecontroller>();

  final selectBranchId = Rxn<int>();
  final selectEmployeeId = Rxn<int>();
  final loanAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "ខ្ចីបន្ថែម"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(
              "សាខា",
              style: TextStyles.siemreap(
                context,
                fontSize: 12,
                fontweight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CustomDropdown(
              selectedValue: selectBranchId,
              items: branchController.branch,
              hintText: "ជ្រើសសាខា",
              onChanged: (value) async {
                selectBranchId.value = value;
                employeeController.employees.clear();
                await employeeController.fetchemployee(
                  branchid: selectBranchId.value,
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              "បុគ្គលិក",
              style: TextStyles.siemreap(
                context,
                fontSize: 12,
                fontweight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CustomDropdown(
              selectedValue: selectEmployeeId,
              items: employeeController.employees,
              hintText: "ជ្រើសបុគ្គលិក",
              onChanged: (value) async {
                selectEmployeeId.value = value;
              },
            ),
            const SizedBox(height: 10),
            Text(
              "ចំនួនលុយ",
              style: TextStyles.siemreap(
                context,
                fontSize: 12,
                fontweight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: loanAmountController,
              hintText: "ឧ. 200",
              prefixIcon: Icons.monetization_on,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        title: "បញ្ចូន",
        onTap: () async {
          final loanAmount = double.tryParse(loanAmountController.text.trim());

          if (selectEmployeeId.value == null ||
              selectBranchId.value == null ||
              loanAmount == null) {
            CustomSnackbar.error(
              title: "បញ្ហា",
              message: "សូមបំពេញព័ត៌មានអោយបានត្រឹមត្រូវ",
            );
            return;
          }

          await loanController.createLoan(
            employeeId: selectEmployeeId.value!,
            loanAmount: loanAmount,
          );
        },
      ),
    );
  }
}
