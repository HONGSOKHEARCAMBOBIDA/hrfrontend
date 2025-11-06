import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/format.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/summarypayrollmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class PayrollCard extends StatelessWidget {
  final Data payrollData;
  
  const PayrollCard({Key? key, required this.payrollData}) : super(key: key);

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
                 _InfoItem('ឈ្មោះ ខ្មែរ', payrollData.nameKh ?? 'N/A'),
              
                _InfoItem('អង់គ្លេស', payrollData.nameEn ?? 'N/A'),
               
                _InfoItem('ភេទ', payrollData.genderText ?? 'N/A'),
                _InfoItem('តួនាទី', payrollData.roleName ?? 'N/A'),
                _InfoItem('ធ្វេីការ', payrollData.typeText ?? 'N/A'),
              ]),
              const SizedBox(height: 16),
              
              // Work Details
              _buildSectionTitle('ព័តមាន ការងារ'),
              _buildInfoGrid([
                _InfoItem('សាខា', payrollData.branchName ?? 'N/A'),
                _InfoItem('វ៉េនធ្វេីការ', payrollData.shiftName ?? 'N/A'),
                _InfoItem('ម៉ោង ធ្វេីការ', '${FormatUtils.formatTime(payrollData.startTime)} - ${FormatUtils.formatTime(payrollData.endTime)}'),
                _InfoItem('ចំនូន ថ្ងៃធ្វេីការ', payrollData.workedDay?.toString() ?? '0'),
                _InfoItem('ចំនួន ថ្ងៃមកធ្វេីការ', payrollData.attendancecount?.toString() ?? '0'),
              ]),
              const SizedBox(height: 16),
              
              // Salary Information
              _buildSectionTitle('ព័តមាន ប្រាក់ខែ'),
              _buildSalarySection(),
              const SizedBox(height: 16),
              
              // Deductions
              _buildSectionTitle('លុយកាត់សរុប'),
              _buildDeductionsSection(),
              const SizedBox(height: 16),
              
              // Loan Information
              if (payrollData.loanAmount! != null)
                Column(
                  children: [
                    _buildSectionTitle('លុយជំពាក់'),
                    _buildLoanSection(),
                    const SizedBox(height: 16),
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
                payrollData.nameKh ?? 'Unknown Employee',
                style: GoogleFonts.siemreap(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: TheColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                payrollData.roleName ?? 'No Role',
                style:  GoogleFonts.siemreap(
                  fontSize: 14,
                  color: TheColors.orange,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getNetSalaryColor(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            FormatUtils.formatCurrency(payrollData.netsalary),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: TheColors.secondaryColor,
              ),
            ),
            SizedBox(width: 6,),
            Text(
              value,
              style:  GoogleFonts.siemreap(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: TheColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalarySection() {
    return Column(
      children: [
        _buildAmountRow('ប្រាក់ខែ', payrollData.baseSalary),
        _buildAmountRow('ប្រាក់ជួលក្នុងមួយថ្ងៃ', payrollData.dailyRate),
        _buildAmountRow('ប្រាក់ត្រូវបេីក', payrollData.netsalary, isTotal: true),
      ],
    );
  }

  Widget _buildDeductionsSection() {
    return Column(
      children: [
        if (payrollData.totalLate != null && payrollData.totalLate! > 0)
          _buildDeductionRow('ចំនូនមកយឺត', payrollData.totalLate, payrollData.penaltylate),
        if (payrollData.totalEarlyexit != null && payrollData.totalEarlyexit! > 0)
          _buildDeductionRow('ចំនួនចេញមុនម៉ោង', payrollData.totalEarlyexit, payrollData.totalexitpenalty),
        if (payrollData.leaveWithPermission != null && payrollData.leaveWithPermission! > 0)
          _buildDeductionRow('ឈប់មានច្បាប់', payrollData.leaveWithPermission, payrollData.penaltyLeaveWithPermission),
        if (payrollData.leaveWithoutPermission != null && payrollData.leaveWithoutPermission! > 0)
          _buildDeductionRow('ឈប់អត់ច្បាប់', payrollData.leaveWithoutPermission, payrollData.penaltyLeaveWithoutPermission),
        if (payrollData.leaveWeekend != null && payrollData.leaveWeekend! > 0)
          _buildDeductionRow('ឈប់សុក្រ/សៅរ៍', payrollData.leaveWeekend, payrollData.penaltyLeaveWeekend),
        _buildAmountRow('លុយត្រូវកាត់សរុប', payrollData.totalDeductions, isDeduction: true),
      ],
    );
  }

  Widget _buildLoanSection() {
    return Column(
      children: [
        _buildAmountRow('លុយដេីម', payrollData.loanAmount),
        _buildAmountRow('លុយនៅជំពាក់', payrollData.remainingBalance),
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
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDeduction ? TheColors.errorColor : TheColors.successColor,
            ),
          ),
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
            style: const TextStyle(fontSize: 11, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Color _getNetSalaryColor() {
    final netSalary = payrollData.netsalary!  ?? 0;
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