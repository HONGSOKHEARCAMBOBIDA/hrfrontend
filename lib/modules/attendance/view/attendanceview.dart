import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_isactive_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_shitf_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/attendance/controller/attendancecontroller.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/attendancecard.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Attendanceview extends StatefulWidget {
  const Attendanceview({super.key});

  @override
  State<Attendanceview> createState() => _AttendanceviewState();
}

class _AttendanceviewState extends State<Attendanceview> {
  final branchcontroller = Get.find<Branchcontroller>();

  final attendancecontroller = Get.find<Attendancecontroller>();
  final TextEditingController searchController = TextEditingController();

  final selectBranchId = Rxn<int>();

  final isLate = Rxn<int>();
  final isLeftEarly = Rxn<int>();
  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();
    String formatDate(String? isoDate) {
      if (isoDate == null || isoDate.isEmpty) return 'N/A';
      try {
        final date = DateTime.parse(isoDate);
        return DateFormat('dd/MM/yyyy').format(date);
        // OR Khmer: return DateFormat('dd MMMM yyyy', 'km').format(date);
      } catch (e) {
        return 'N/A';
      }
    }
  Widget _buildLabel(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyles.siemreap(context, fontSize: 10)),
        const Icon(Icons.arrow_drop_down, color: TheColors.errorColor, size: 18),
      ],
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      initialDateRange: startDate.value != null && endDate.value != null
          ? DateTimeRange(start: startDate.value!, end: endDate.value!)
          : null,
    );

    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
      _applyFilters();
    }
  }

  void _applyFilters() {
    attendancecontroller.fetchattendance(
      branchID: selectBranchId.value,
      islate: isLate.value,
      isLeftEarly: isLeftEarly.value,
      startdate: startDate.value != null
          ? DateFormat('yyyy-MM-dd').format(startDate.value!)
          : null,
      enddate: endDate.value != null
          ? DateFormat('yyyy-MM-dd').format(endDate.value!)
          : null,
      name: attendancecontroller.searchQuery.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: "របាយការណ៍ម៉ោងចូលនិងម៉ោងចេញ"),
        backgroundColor: TheColors.bgColor,
        body: RefreshIndicator(
          onRefresh: () async {
            searchController.clear();
            selectBranchId.value = null;
            attendancecontroller.searchQuery.value ='';
            isLate.value = null;
            isLeftEarly.value = null;
            startDate.value = null;
            endDate.value = null;
            attendancecontroller.attendance.clear();
            await attendancecontroller.fetchattendance();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search box
                SizedBox(
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField(
                        controller: searchController,
                        hintText: "ស្វែងរក".tr,
                        prefixIcon: Icons.search,
                        onChanged: (value) =>
                            attendancecontroller.searchQuery.value = value,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
            
                // 🧭 Filters
                Padding(
                  padding: const EdgeInsets.only(left: 14,right: 11),
                  child: Row(
                    children: [
                      // 🏢 Branch filter
                      TextButton(
                        style: _filterStyle(),
                        onPressed: () {
                          showBranchSelectorSheet(
                            context: context,
                            branch: branchcontroller.branch,
                            selectedBranchId: selectBranchId.value,
                            onSelected: (id) {
                              selectBranchId.value = id;
                              _applyFilters();
                            },
                          );
                        },
                        child: _buildLabel("សាខា"),
                      ),
                      
                      const SizedBox(width: 4),
                              
                      // 🕓 Late filter
                      TextButton(
                        style: _filterStyle(),
                        onPressed: () {
                          setState(() {
                            isLate.value = (isLate.value == 1) ? null : 1;
                            _applyFilters();
                          });
                        },
                        child: _buildLabel("យឺត"),
                      ),
                      const SizedBox(width: 4),
                              
                      // ⏰ Left early filter
                      TextButton(
                        style: _filterStyle(),
                        onPressed: () {
                          setState(() {
                            isLeftEarly.value =
                                (isLeftEarly.value == 1) ? null : 1;
                            _applyFilters();
                          });
                        },
                        child: _buildLabel("ចេញមុន"),
                      ),
                      const SizedBox(width: 7),
                              
                      // 📅 Date range filter
                      TextButton(
                        style: _filterStyle(),
                        onPressed: _selectDateRange,
                        child: Obx(() {
                          if (startDate.value != null &&
                              endDate.value != null) {
                            return Text(
                              "${DateFormat('dd/MM').format(startDate.value!)} - ${DateFormat('dd/MM').format(endDate.value!)}",
                              style:
                                  TextStyles.siemreap(context, fontSize: 10),
                            );
                          }
                          return _buildLabel("កាលបរិច្ឆេទ");
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
            
                // 🧾 Attendance list
                Expanded(
                  child: Obx(() {
                    if (attendancecontroller.isLoading.value) {
                      return const CustomLoading();
                    }
            
                    if (attendancecontroller.attendance.isEmpty) {
                      return Center(
                        child: Text(
                          'អត់ទាន់មានទិន្ន័យ',
                          style: TextStyles.siemreap(context, fontSize: 12),
                        ),
                      );
                    }
            
                    return ListView.builder(
                      itemCount: attendancecontroller.attendance.length,
                      itemBuilder: (context, index) {
                        final attendnce = attendancecontroller.attendance[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomAttendanceCard(
                            nameKh: attendnce.nameKh ?? '',
                            nameEn: attendnce.nameEn ?? '',
                            role: attendnce.roleName ?? '',
                            checkIn: attendnce.checkIn ?? '',
                            checkOut: attendnce.checkOut ?? '',
                            checkDate: formatDate(attendnce.checkDate)  ?? '',
                            shiftName: attendnce.shiftName ?? '',
                            branchName: attendnce.branchName ?? '',
                            isLate: attendnce.isLate ?? 0,
                            isLeftEarly: attendnce.isLeftEarly ?? 0,
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _filterStyle() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: const BorderSide(color: TheColors.errorColor, width: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
