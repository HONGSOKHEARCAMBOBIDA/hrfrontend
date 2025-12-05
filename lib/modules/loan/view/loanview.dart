import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_employee_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/loan/loancontroller/loancontroller.dart';
import 'package:flutter_application_10/modules/loan/view/createloanview.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/loancard.dart';
import 'package:get/get.dart';

class LoanView extends StatefulWidget {
  const LoanView({super.key});

  @override
  State<LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  final branchController = Get.find<Branchcontroller>();
  final employeeController = Get.find<Employeecontroller>();
  final loanController = Get.find<LoanController>();

  final selectBranchId = Rxn<int>();
  final selectEmployeeId = Rxn<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "លុយបុគ្គលិកជំពាក់"),
      body: RefreshIndicator(
           color: TheColors.errorColor,
          backgroundColor: TheColors.bgColor,
        onRefresh: () async {
          selectBranchId.value = null;
          selectEmployeeId.value = null;
          employeeController.employees.clear();
          await loanController.fetchLoan();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              _buildFilters(context),
              SizedBox(height: 10,),
              Expanded(child: _buildLoanList(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.to(
            () => const CreateLoanView(),
            transition: Transition.rightToLeft,
          );
        },
        backgroundColor: TheColors.errorColor,
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: _filterStyle(),
            onPressed: () {
              showBranchSelectorSheet(
                context: context,
                branch: branchController.branch,
                selectedBranchId: selectBranchId.value,
                onSelected: (id) {
                  selectBranchId.value = id;
                  loanController.fetchLoan(branchId: id);
                  employeeController.fetchemployee(branchid: id);
                },
              );
            },
            child: _buildLabel("សាខា"),
          ),
          const SizedBox(width: 5),
          TextButton(
            style: _filterStyle(),
            onPressed: () {
              showemployeebuttonsheet(
                context: context,
                employee: employeeController.employees,
                selectEmployeeId: selectEmployeeId.value,
                onSelected: (id) {
                  selectEmployeeId.value = id;
                  loanController.fetchLoan(employeeId: id);
                },
              );
            },
            child: _buildLabel("បុគ្គលិក"),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanList(BuildContext context) {
    return Obx(() {
      if (loanController.isLoading.value) return const CustomLoading();

      if (loanController.loan.isEmpty) {
        return Center(
          child: Text(
            'អត់ទាន់មានទិន្ន័យ',
            style: TextStyles.siemreap(context, fontSize: 12),
          ),
        );
      }

      return ListView.builder(
        itemCount: loanController.loan.length,
        itemBuilder: (context, index) {
          final loan = loanController.loan[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
            child: LoanCard(
  currencyname: loan.currencyName!,
  currencyId: loan.currencyId!,
  loanId: loan.id!,
  employeeId: loan.employeeId!,
  employeeName: loan.employeeName ?? "N/A",
  branchName: loan.branchName ?? "N/A",
  loanAmount: loan.loanAmount?.toDouble() ?? 0.0,
  remainingBalance: loan.remainingBalance?.toDouble() ?? 0.0,
  status: loan.status ?? 0,
),

          );
        },
      );
    });
  }

  ButtonStyle _filterStyle() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: const BorderSide(color: TheColors.errorColor, width: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildLabel(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyles.siemreap(context, fontSize: 10)),
        
        const Icon(
          Icons.arrow_drop_down,
          color: TheColors.errorColor,
          size: 18,
        ),
      ],
    );
  }
}
