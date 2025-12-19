import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/usermodel.dart' as mymodel;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserDetailBottomSheet extends StatelessWidget {
  final mymodel.Data user;

  const UserDetailBottomSheet({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   

    // String formatDate(String? isoDate) {
    //   if (isoDate == null || isoDate.isEmpty) return 'N/A';
    //   try {
    //     final date = DateTime.parse(isoDate);
    //     return DateFormat('dd/MM/yyyy').format(date);
    //     // OR Khmer: return DateFormat('dd MMMM yyyy', 'km').format(date);
    //   } catch (e) {
    //     return 'N/A';
    //   }
    // }

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: TheColors.bgColor,
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
            const SizedBox(height: 8),
            _buildHeader(context),
            const SizedBox(height: 5),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: TheColors.orange, width: 0.4),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(Icons.person,'ព័ត៌មានផ្ទាល់ខ្លួន'),
                        Divider(height: 8, color: TheColors.orange),
                        _buildDetailItem('ឈ្មោះ', user.name ?? 'N/A'),
                        _buildDetailItem('ឈ្មោះអង់គ្លេស', user.nameEn ?? 'N/A'),
                        _buildDetailItem('ភេទ', _getGender(user.gender)),
                        _buildDetailItem(
                          'លេខអត្តសញ្ញាណ',
                          user.nationalIdNumber ?? 'N/A',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: TheColors.orange, width: 0.4),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(Icons.work_outline,'ព័ត៌មានការងារ'),
                        Divider(height: 8, color: TheColors.orange),
                        _buildDetailItem('តួនាទី', user.roleName ?? 'N/A'),
                        _buildDetailItem('សាខា', user.branchName ?? 'N/A'),
                        _buildDetailItem(
                          'ស្ថានភាព',
                          user.isActive == true ? 'សកម្ម' : 'អសកម្ម',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: TheColors.orange, width: 0.4),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(Icons.note_outlined,'ទំនាក់ទំនង'),
                        Divider(height: 8, color: TheColors.orange),
                        _buildDetailItem('អ៊ីម៉ែល', user.email ?? 'N/A'),
                        _buildDetailItem('ទូរស័ព្ទ', user.contact ?? 'N/A'),
                      ],
                    ),
                  ),

                 
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
                           decoration: BoxDecoration(
      border: Border.all(
        color: TheColors.warningColor,// Border color
        width: 0.9,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child:CircleAvatar(
              
  radius: 50,
  backgroundImage: AssetImage('assets/user/information.png'),
),

          ),
        ),
        const SizedBox(height: 12),
        Text(
          user.name ?? 'N/A',
          style: GoogleFonts.siemreap(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TheColors.secondaryColor,
          ),
        ),
        if (user.roleName != null) ...[
          const SizedBox(height: 4),
          Text(
            user.roleName!,
            style: GoogleFonts.siemreap(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(  IconData icon,String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: TheColors.orange, size: 18),
             const SizedBox(width: 6),
          Text(
            title,
            style: GoogleFonts.siemreap(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: TheColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
            child: Text(value, style: GoogleFonts.siemreap(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  String _getGender(int? gender) {
    if (gender == null) return 'N/A';
    return gender == 1 ? 'ប្រុស' : 'ស្រី';
  }

  String _getmaterial(int? material) {
    if (material == null) return 'N/A';
    return material == 1 ? 'នៅលីវ' : 'មានគ្រួសារ';
  }
}
