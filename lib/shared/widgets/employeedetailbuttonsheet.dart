import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart' as mymodel;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Employeedetailbuttonsheet extends StatelessWidget {
  final mymodel.Data employee;

  const Employeedetailbuttonsheet({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String formatDate(String? isoDate) {
      if (isoDate == null || isoDate.isEmpty) return 'N/A';
      try {
        final date = DateTime.parse(isoDate);
        return DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        return 'N/A';
      }
    }

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
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
            _buildHeader(context),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSection(
                    icon: Icons.person,
                    title: 'ព័ត៌មានផ្ទាល់ខ្លួន',
                    children: [
                      _buildDetailItem('ឈ្មោះ', employee.name ?? 'N/A'),
                      _buildDetailItem('ឈ្មោះអង់គ្លេស', employee.nameEn ?? 'N/A'),
                      _buildDetailItem('ភេទ', _getGender(employee.gender)),
                      _buildDetailItem('ថ្ងៃកំណើត', formatDate(employee.dob)),
                      _buildDetailItem('លេខអត្តសញ្ញាណ',
                          employee.nationalIdNumber ?? 'N/A'),
                      _buildDetailItem('លេខទូរស័ព្ទ', employee.contact ?? 'N/A'),
                    ],
                  ),
                  _buildSection(
                    icon: Icons.work_outline,
                    title: 'ព័ត៌មានការងារ',
                    children: [
                      _buildDetailItem('តួនាទី', employee.roleName ?? 'N/A'),
                      _buildDetailItem('សាខា', employee.branchName ?? 'N/A'),
                      _buildDetailItem('ប្រភេទការងារ',
                          employee.type == 1 ? 'ពេញម៉ោង' : 'កាលបរិច្ឆេទ'),
                      _buildDetailItem('ថ្ងៃចូលបំពេញការងារ',
                          formatDate(employee.hireDate)),
                      _buildDetailItem('វេន', employee.shiftName ?? 'N/A'),
                      _buildDetailItem('ម៉ោងធ្វើការ',
                          '${employee.startTime ?? ''} - ${employee.endTime ?? ''}'),
                      _buildDetailItem(
                          'ប្រាក់ខែគោល',
                          employee.baseSalary != null
                              ? '${employee.baseSalary} ដុល្លា'
                              : 'N/A'),
                      _buildDetailItem('ស្ថានភាព',
                          employee.isActive == true ? 'សកម្ម' : 'អសកម្ម'),
                    ],
                  ),
                  _buildSection(
                    icon: Icons.location_on_outlined,
                    title: 'អាសយដ្ឋាន',
                    children: [
                      _buildDetailItem('ខេត្ត', employee.provinceName ?? 'N/A'),
                      _buildDetailItem('ស្រុក', employee.districtName ?? 'N/A'),
                      _buildDetailItem('ឃុំ', employee.communeName ?? 'N/A'),
                      _buildDetailItem('ភូមិ', employee.villageName ?? 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HEADER =====================
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: const NetworkImage(
            'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          employee.name ?? 'N/A',
          style: GoogleFonts.siemreap(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TheColors.secondaryColor,
          ),
        ),
        if (employee.roleName != null) ...[
          const SizedBox(height: 4),
          Text(
            employee.roleName!,
            style: GoogleFonts.siemreap(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: employee.isActive == true
                ? TheColors.successColor.withOpacity(0.2)
                : TheColors.errorColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            employee.isActive == true ? 'សកម្ម' : 'អសកម្ម',
            style: GoogleFonts.siemreap(
              color: employee.isActive == true
                  ? TheColors.successColor
                  : TheColors.errorColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ==================== SECTION WRAPPER =====================
  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TheColors.bgColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: TheColors.orange, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.siemreap(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: TheColors.secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(height: 8),
          ...children,
        ],
      ),
    );
  }

  // ==================== DETAIL ROW =====================
  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.siemreap(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.siemreap(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPERS =====================
  String _getGender(int? gender) {
    if (gender == null) return 'N/A';
    return gender == 1 ? 'ប្រុស' : 'ស្រី';
  }
}
