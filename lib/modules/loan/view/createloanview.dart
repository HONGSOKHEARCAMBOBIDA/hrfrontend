import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/showcurrencyselector.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/loan/loancontroller/loancontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
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
  final currencycontroller = Get.find<Currencycontroller>();

  final selectBranchId = Rxn<int>();
  final selectEmployeeId = Rxn<int>();
  final selectcurrencyId = Rxn<int>();
  final loanAmountController = TextEditingController();
  var selectedbranchname = "ជ្រេីសរេីសសាខា".obs;
    var selectedcurrencyname = "សូមជ្រេីសរេីសរូបិយប័ណ្ណ".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "ខ្ចីបន្ថែម"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: TheColors.orange, width: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                
                    Obx(
                      () => CustomOutlinedButton(
                        text: selectedbranchname.value.isEmpty
                            ? "រេីសសាខា"
                            : selectedbranchname.value,
                        onPressed: () {
                          showBranchSelectorSheet(
                            context: context,
                            branch: branchController.branch,
                            onSelected: (id) {
                              selectBranchId.value = id;
                              selectedbranchname.value = branchController.branch
                                  .firstWhere((p) => p.id == id)
                                  .name!;
                              employeeController.employees.clear();
                              employeeController.fetchemployee(
                                branchid: selectBranchId.value,
                              );
                            },
                          );
                        },
                      ),
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
                      "រូបិយប័ណ្ណដែលប្រី",
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 12,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 5,),
                                                          Obx(
                                                () => CustomOutlinedButton(
                                                  
                                                  text: selectedcurrencyname.value.isEmpty
                                                      ? "សូមជ្រេីសរេីសរុបិយប័ណ្ណ"
                                                      : selectedcurrencyname.value,
                                                  onPressed: () {
                                                    showcurrencyselector(
                                                      context: context,
                                                      currency:
                                                          currencycontroller.currency,
                                                      onSelected: (id) {
                                                        selectcurrencyId.value = id;
                                                        selectedcurrencyname
                                                            .value = currencycontroller
                                                            .currency
                                                            .firstWhere((p) => p.id == id)
                                                            .name!;
                                                      },
                                                    );
                                                  },
                                                  
                                                ),
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
                      prefixIcon: Icons.wallet
                    ),
                  ],
                ),
              ),
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
            currencyId: selectcurrencyId.value!,
            employeeId: selectEmployeeId.value!,
            loanAmount: loanAmount,
          );
        },
      ),
    );
  }
}
