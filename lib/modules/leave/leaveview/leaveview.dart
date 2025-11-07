import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_employee_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_isactive_buttonsheet.dart';

import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/auth/binding/authbinding.dart';

import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/leave/leavecontroller/leavecontroller.dart';
import 'package:flutter_application_10/modules/leave/leaveview/createleaveview.dart';
import 'package:flutter_application_10/modules/leave/leaveview/update_leave_view.dart';

import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';

import 'package:flutter_application_10/shared/widgets/leavecard.dart';

import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Leaveview extends StatefulWidget {
  const Leaveview({super.key});

  @override
  State<Leaveview> createState() => _LeaveviewState();
}

class _LeaveviewState extends State<Leaveview> {
  final branchcontroller = Get.find<Branchcontroller>();
  final employeecontroller = Get.find<Employeecontroller>();
  final leavecontroller = Get.find<Leavecontroller>();
  final TextEditingController searchController = TextEditingController();
  final ispermission = Rxn<int>();
  final iswithoutpermission = Rxn<int>();
  final isweekend = Rxn<int>();
  final status = Rxn<int>();
  final currentstate = Rxn<int>();
  final selectBranchId = Rxn<int>();
  final selectEmployeeID = Rxn<int>();
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
        const Icon(
          Icons.arrow_drop_down,
          color: TheColors.errorColor,
          size: 18,
        ),
      ],
    );
  }

  void _applyFilters() {
    leavecontroller.fetchleave(
      branchid: selectBranchId.value,
      employeeid: selectEmployeeID.value,
      ispermission: ispermission.value,
      iswithoutpermission: iswithoutpermission.value,
      isWeekend: isweekend.value,
      status: status.value,
      employeename: leavecontroller.searchQuery.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: "របាយការណ៍សុំច្បាប់"),
        backgroundColor: TheColors.bgColor,
        body: RefreshIndicator(
          onRefresh: () async {
            employeecontroller.employees.clear();
            searchController.clear();
            selectBranchId.value = null;
            leavecontroller.searchQuery.value = '';
            ispermission.value = null;
            iswithoutpermission.value = null;
            isweekend.value = null;
            status.value = null;
            leavecontroller.leave.clear();
            await leavecontroller.fetchleave();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
              top: 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search box
                SizedBox(
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 15,
                      bottom: 10,
                    ),
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField(
                        controller: searchController,
                        hintText: "ស្វែងរក".tr,
                        prefixIcon: Icons.search,
                        onChanged: (value) =>
                            leavecontroller.searchQuery.value = value,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                // 🧭 Filters
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                                employeecontroller.fetchemployee(
                                  branchid: selectBranchId.value,
                                );
                                _applyFilters();
                              },
                            );
                          },
                          child: _buildLabel("សាខា"),
                        ),
                                        
                        const SizedBox(width: 4),
                        TextButton(
                          style: _filterStyle(),
                          onPressed: () {
                            showemployeebuttonsheet(
                              context: context,
                              employee: employeecontroller.employees,
                              selectEmployeeId: selectEmployeeID.value,
                              onSelected: (id) {
                                selectEmployeeID.value = id;
                                _applyFilters();
                              },
                            );
                          },
                          child: _buildLabel("បុគ្គលិក"),
                        ),
                        const SizedBox(width: 4),
                        // 🕓 Late filter
                        TextButton(
                          style: _filterStyle(),
                          onPressed: () {
                            setState(() {
                              ispermission.value = (ispermission.value == 1)
                                  ? null
                                  : 1;
                              _applyFilters();
                            });
                          },
                          child: _buildLabel("មានច្បាប់"),
                        ),
                        const SizedBox(width: 4),
                                        
                        // ⏰ Left early filter
                        TextButton(
                          style: _filterStyle(),
                          onPressed: () {
                            setState(() {
                              iswithoutpermission.value =
                                  (iswithoutpermission.value == 1) ? null : 1;
                              _applyFilters();
                            });
                          },
                          child: _buildLabel("គ្មានច្បាប់"),
                        ),
                        const SizedBox(width: 4),
                                        
                        // ⏰ Left early filter
                        TextButton(
                          style: _filterStyle(),
                          onPressed: () {
                            setState(() {
                              isweekend.value = (isweekend.value == 1) ? null : 1;
                              _applyFilters();
                            });
                          },
                          child: _buildLabel("សុក្រ ~ សៅរ៍"),
                        ),
                        const SizedBox(width: 4),
                                        
                        TextButton(
                          style: _filterStyle(),
                          onPressed: () {
                            showIsActiveSelectorSheet(
                              context: context,
                              selectedValue: currentstate.value, // e.g. 1 or 0
                              onSelected: (value) {
                                setState(() {
                                  currentstate.value = value;
                                  leavecontroller.fetchleave(
                                    status: currentstate.value!,
                                  );
                                });
                              },
                            );
                          },
                          child: _buildLabel("ស្ថានភាព"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // 🧾 Attendance list
                Expanded(
                  child: Obx(() {
                    if (leavecontroller.isLoading.value) {
                      return const CustomLoading();
                    }

                    if (leavecontroller.leave.isEmpty) {
                      return Center(
                        child: Text(
                          'អត់ទាន់មានទិន្ន័យ',
                          style: TextStyles.siemreap(context, fontSize: 12),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: leavecontroller.leave.length,
                      itemBuilder: (context, index) {
                        final leave = leavecontroller.leave[index];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: LeaveCard(leaveData: leave,onTap: (){
                            Get.to(()=>UpdateLeaveView(leaveData: leave),binding: Authbinding());
                          },),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: CustomFloatingActionButton(
          backgroundColor: TheColors.errorColor,
          onPressed: (){
          Get.to(()=>CreateLeaveView(),transition: Transition.rightToLeft,binding: Authbinding());
        }),
      ),
    );
  }

  ButtonStyle _filterStyle() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: const BorderSide(color: TheColors.errorColor, width: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
