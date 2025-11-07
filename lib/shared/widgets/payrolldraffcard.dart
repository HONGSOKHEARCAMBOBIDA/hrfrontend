import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/format.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/summarypayrollmodel.dart';
import 'package:flutter_application_10/modules/payroll/payrollcontroller/payrollcontroller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class PayrollCard extends StatefulWidget {
  final Data payrollData;
  final Function(double, int) onLoanDeductionChanged;

   PayrollCard({Key? key, required this.payrollData,required this.onLoanDeductionChanged,}) : super(key: key);

  @override
  State<PayrollCard> createState() => _PayrollCardState();
}

class _PayrollCardState extends State<PayrollCard> {
  final payrollcontroller = Get.put(Payrollcontroller());
  final loandeduction = TextEditingController();
  final RxDouble deduction = 0.0.obs; // 👈 this one is unique for each card
  @override
  void initState() {
    super.initState();
    loandeduction.addListener(() {
          double newDeduction = double.tryParse(loandeduction.text) ?? 0;
      deduction.value = newDeduction;  
        if (widget.payrollData.salaryId != null) {
        widget.onLoanDeductionChanged(newDeduction, widget.payrollData.salaryId!);
      }
    });
  }

  @override
  void dispose() {
    loandeduction.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: TheColors.orange,width: 0.5),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeaderSection(),
              const SizedBox(height: 16),
              
              // Basic Information
              _buildSectionTitle('ព័តមាន បុគ្គលិក'),
              _buildInfoGrid([
                 _InfoItem('ឈ្មោះ ខ្មែរ', widget.payrollData.nameKh ?? 'N/A'),
              
                _InfoItem('អង់គ្លេស', widget.payrollData.nameEn ?? 'N/A'),
               
                _InfoItem('ភេទ', widget.payrollData.genderText ?? 'N/A'),
                _InfoItem('តួនាទី', widget.payrollData.roleName ?? 'N/A'),
                _InfoItem('ធ្វេីការ', widget.payrollData.typeText ?? 'N/A'),
              ]),
              const SizedBox(height: 8),
              Divider(color: TheColors.orange,thickness: 0.5,),
                SizedBox(height: 8),
              // Work Details
              _buildSectionTitle('ព័តមាន ការងារ'),
              _buildInfoGrid([
                _InfoItem('សាខា', widget.payrollData.branchName ?? 'N/A'),
                _InfoItem('វ៉េនធ្វេីការ', widget.payrollData.shiftName ?? 'N/A'),
                _InfoItem('ម៉ោង ធ្វេីការ', '${FormatUtils.formatTime(widget.payrollData.startTime)} - ${FormatUtils.formatTime(widget.payrollData.endTime)}'),
                _InfoItem('ចំនូន ថ្ងៃធ្វេីការ', widget.payrollData.workedDay?.toString() ?? '0'),
                _InfoItem('ចំនួន ថ្ងៃមកធ្វេីការ', widget.payrollData.attendancecount?.toString() ?? '0'),
              ]),
              const SizedBox(height: 5),
                Divider(color: TheColors.orange,thickness: 0.5,),
               const SizedBox(height: 5),  
              
              // Salary Information
              _buildSectionTitle('ព័តមាន ប្រាក់ខែ'),
              _buildSalarySection(),
              const SizedBox(height: 5),
               Divider(color: TheColors.orange,thickness: 0.5,),
               const SizedBox(height: 5),
              
              // Deductions
              _buildSectionTitle('លុយកាត់សរុប'),
              _buildDeductionsSection(),
              const SizedBox(height: 5),
               Divider(color: TheColors.orange,thickness: 0.5,),
              const SizedBox(height: 5),
              // Loan Information
              if (widget.payrollData.loanAmount != null)
                Column(
                  children: [
                    _buildSectionTitle('លុយជំពាក់'),
                    _buildLoanSection(),
                    const SizedBox(height: 10),
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }

Widget _buildHeaderSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.payrollData.nameKh ?? 'Unknown Employee',
              style: GoogleFonts.siemreap(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: TheColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.payrollData.roleName ?? 'No Role',
              style: GoogleFonts.siemreap(
                fontSize: 14,
                color: TheColors.orange,
              ),
            ),
          ],
        ),
      ),

      // 👇 Wrap the container that depends on deduction inside Obx
      Obx(() {
         final bonus = (widget.payrollData.isBonusAttendanace == 1)
      ? (widget.payrollData.bonusAmount ?? 10)
      : 0; 
        final netSalary =
            (widget.payrollData.netsalary ?? 0) - deduction.value + bonus;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getNetSalaryColor(netSalary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            FormatUtils.formatCurrency(netSalary),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }),
    ],
  );
}


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: TheColors.secondaryColor,
        ),
      ),
    );
  }

Widget _buildInfoGrid(List<_InfoItem> items) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final rowCount = (items.length / 2).ceil(); // two items per row
      return Column(
        children: List.generate(rowCount, (rowIndex) {
          final firstIndex = rowIndex * 2;
          final secondIndex = firstIndex + 1;
          final firstItem = items[firstIndex];
          final secondItem = secondIndex < items.length ? items[secondIndex] : null;

          return Row(
            children: [
              Expanded(child: _buildInfoRow(firstItem.label, firstItem.value)),
              if (secondItem != null)
                Expanded(child: _buildInfoRow(secondItem.label, secondItem.value))
              else
                const Spacer(),
            ],
          );
        }),
      );
    },
  );
}

  Widget _buildInfoRow(String label, String value) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label:',
              style: GoogleFonts.siemreap(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: TheColors.secondaryColor,
              ),
            ),
            SizedBox(width: 6,),
            Text(
              value,
              style:  GoogleFonts.siemreap(
                fontSize: 11,
              fontWeight: FontWeight.w500,
                color: TheColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget _buildSalarySection() {
  final bonus = (widget.payrollData.isBonusAttendanace == 1)
      ? (widget.payrollData.bonusAmount ?? 10)
      : 0;


  return Obx(() => Column(
        children: [
          _buildAmountRow('ប្រាក់ខែ', widget.payrollData.baseSalary),
          _buildAmountRow('ប្រាក់ជួលក្នុងមួយថ្ងៃ', widget.payrollData.dailyRate),
          _buildAmountRow('ប្រាក់មិនទាន់កាត់', widget.payrollData.notdeduction),
          _buildAmountRow(
            'ប្រាក់ត្រូវបើក',
            (widget.payrollData.netsalary ?? 0) - deduction.value + bonus,
            isTotal: true,
          ),
          _buildAmountRow('ប្រាក់លើកទឹកចិត្ត', bonus),
        ],
      ));
}


  Widget _buildDeductionsSection() {
    return Column(
      children: [
        if (widget.payrollData.totalLate != null && widget.payrollData.totalLate! > 0)
          _buildDeductionRow('ចំនូនមកយឺត', widget.payrollData.totalLate, widget.payrollData.penaltylate),
        if (widget.payrollData.totalEarlyexit != null && widget.payrollData.totalEarlyexit! > 0)
          _buildDeductionRow('ចំនួនចេញមុនម៉ោង', widget.payrollData.totalEarlyexit, widget.payrollData.totalexitpenalty),
        if (widget.payrollData.leaveWithPermission != null && widget.payrollData.leaveWithPermission! > 0)
          _buildDeductionRow('ឈប់មានច្បាប់', widget.payrollData.leaveWithPermission, widget.payrollData.penaltyLeaveWithPermission),
        if (widget.payrollData.leaveWithoutPermission != null && widget.payrollData.leaveWithoutPermission! > 0)
          _buildDeductionRow('ឈប់អត់ច្បាប់', widget.payrollData.leaveWithoutPermission, widget.payrollData.penaltyLeaveWithoutPermission),
        if (widget.payrollData.leaveWeekend != null && widget.payrollData.leaveWeekend! > 0)
          _buildDeductionRow('ឈប់សុក្រ/សៅរ៍', widget.payrollData.leaveWeekend, widget.payrollData.penaltyLeaveWeekend),
        _buildAmountRow('លុយត្រូវកាត់សរុប', widget.payrollData.totalDeductions, isDeduction: true),
      ],
    );
  }

  Widget _buildLoanSection() {
    return Column(
      children: [
        _buildAmountRow('លុយដេីម', widget.payrollData.loanAmount),
        _buildAmountRow('លុយនៅជំពាក់', widget.payrollData.remainingBalance),
        _buildAmountRowwithTextfield('លុយសង')
      ],
    );
  }

  Widget _buildAmountRow(String label, dynamic amount, {bool isTotal = false, bool isDeduction = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.siemreap(
              fontSize: 11,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDeduction ? TheColors.errorColor : TheColors.secondaryColor,
            ),
          ),
          Text(
            FormatUtils.formatCurrency(amount),
            style: GoogleFonts.siemreap(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isDeduction ? TheColors.errorColor : TheColors.successColor,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildAmountRowwithTextfield(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.siemreap(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: TheColors.secondaryColor,
            ),
          ),
        ),
        const SizedBox(width: 8), // space between text and field
Expanded(
  flex: 1,
  child: TextFormField(
    controller: loandeduction,
    textAlign: TextAlign.center, // 👈 center the hint & input text
    decoration: InputDecoration(
      hintText: 'បញ្ចូលចំនួន',
      hintStyle: GoogleFonts.siemreap(fontSize: 10,color: TheColors.black),
      isDense: true,
      contentPadding: const EdgeInsets.only(left: 1,right: 1,bottom: 6),

      // Normal border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: TheColors.orange, width: 0.8),
      ),

      // Focused border (when user taps)
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: TheColors.secondaryColor, width: 1.2),
      ),

      // Optional: Error border
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.red, width: 0.8),
      ),
    ),
    keyboardType: TextInputType.number,
  ),
)

      ],
    ),
  );
}

  Widget _buildDeductionRow(String label, int? count, double? penalty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '$label ($count ដង)',
              style: GoogleFonts.siemreap(fontSize: 11, color: TheColors.errorColor),
            ),
          ),
          Text(
            FormatUtils.formatCurrency(penalty),
            style: const TextStyle(fontSize: 11, color: TheColors.errorColor,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getNetSalaryColor(double netSalary) {
   
    if (netSalary > 0) {
      return TheColors.successColor;
    } else if (netSalary <= 0) {
      return TheColors.errorColor;
    } else {
      return Colors.blueGrey;
    }
  }
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem(this.label, this.value);
}