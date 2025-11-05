import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/loan/loancontroller/loancontroller.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoanCard extends StatelessWidget {
  final int loanId;
  final int employeeId;
  final String employeeName;
  final String branchName;
  final double loanAmount;
  final double remainingBalance;
  final int status;

  const LoanCard({
    Key? key,
    required this.loanId,
    required this.employeeId,
    required this.employeeName,
    required this.branchName,
    required this.loanAmount,
    required this.remainingBalance,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loanController = Get.find<LoanController>();
    final bool isPaid = status == 0; // 1 = Paid, 0 = Unpaid

    return GestureDetector(
      onTap: () {
        _showUpdateBottomSheet(context, loanController);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 11, right: 11),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: TheColors.orange, width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Employee name + status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      employeeName,
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 14,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPaid ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isPaid ? 'បង់រួច' : 'មិនទាន់បង់រួច',
                        style: TextStyles.siemreap(
                          context,
                          color: isPaid
                              ? TheColors.successColor
                              : TheColors.errorColor,
                          fontweight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  branchName,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 12,
                    color: TheColors.lightblue,
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 0.6,
                  color: TheColors.errorColor,
                ),
                _infoRow('ចំនួនប្រាក់កម្ចី:', '$loanAmount ដុល្លា'),
                const SizedBox(height: 6),
                _infoRow('ប្រាក់នៅសល់:', '$remainingBalance ដុល្លា'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.siemreap(
            fontSize: 13,
            color: TheColors.successColor,
          ),
        ),
        Text(value, style: GoogleFonts.siemreap(fontSize: 13)),
      ],
    );
  }

  void _showUpdateBottomSheet(
    BuildContext context,
    LoanController loanController,
  ) {
    final TextEditingController loanAmountController = TextEditingController(
      text: loanAmount.toString(),
    );
    final TextEditingController remainingBalanceController =
        TextEditingController(text: remainingBalance.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'ធ្វើបច្ចុប្បន្នភាពឥណទាន',
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 14,
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "លុយខ្ចី",
                style: TextStyles.siemreap(
                  context,
                  fontSize: 12,
                  fontweight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              CustomTextField(
                controller: loanAmountController,
                keyboardType: TextInputType.number,
                hintText: "ចំនួនប្រាក់កម្ចី",
                prefixIcon: Icons.monetization_on,
              ),
              const SizedBox(height: 15),
              Text(
                "លុយមិនទាន់សង",
                style: TextStyles.siemreap(
                  context,
                  fontSize: 12,
                  fontweight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              CustomTextField(
                controller: remainingBalanceController,
                keyboardType: TextInputType.number,
                hintText: "ប្រាក់នៅសល់",
                prefixIcon: Icons.monetization_on,
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TheColors.errorColor,
                  minimumSize: const Size.fromHeight(45),
                ),
                icon: const Icon(
                  Icons.monetization_on,
                  color: TheColors.bgColor,
                ),
                label: Text(
                  'ធ្វើបច្ចុប្បន្នភាព',
                  style: GoogleFonts.siemreap(color: TheColors.bgColor),
                ),
                onPressed: () async {
                  await loanController.updateLoan(
                    loanId: loanId,
                    employeeId: employeeId,
                    loanAmount:
                        double.tryParse(loanAmountController.text) ?? 0.0,
                    remainingBalance:
                        double.tryParse(remainingBalanceController.text) ?? 0.0,
                  );
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
