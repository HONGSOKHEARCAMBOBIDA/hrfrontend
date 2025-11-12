import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_isactive_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_role_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_shitf_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart'
    as myModel;

import 'package:flutter_application_10/modules/auth/binding/updateuserbinding.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/auth/view/updateuserview.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeebinding/updateemployeebinding.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/employee/employeeview/updateemployeeview.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/salary/view/editsalaryview.dart';
import 'package:flutter_application_10/modules/salary/view/increasesalaryview.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/employeecard.dart';
import 'package:flutter_application_10/shared/widgets/employeedetailbuttonsheet.dart';
import 'package:flutter_application_10/shared/widgets/employeeshifteditview.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:flutter_application_10/shared/widgets/usercard.dart';
import 'package:flutter_application_10/shared/widgets/userdetailbuttonsheet.dart';
import 'package:get/get.dart';

class Employeeview extends StatefulWidget {
  Employeeview({super.key});

  @override
  State<Employeeview> createState() => _EmployeeviewState();
}

class _EmployeeviewState extends State<Employeeview> {
  final employeecontroller = Get.find<Employeecontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final shiftcontroller = Get.find<Shiftcontroller>();
  final TextEditingController searchController = TextEditingController();
  final selectroleid = Rxn<int>();
  final selectshiftid = Rxn<int>();
  final selectbranchid = Rxn<int>();
  final selectisactive = Rxn<bool>();
  final currentstate = Rxn<int>();
  void _handleViewEmployee(myModel.Data employee) {
    Get.bottomSheet(
      Employeedetailbuttonsheet(employee: employee),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  Widget _buildlabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min, // so it wraps tightly
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 10)),
          const SizedBox(width: 4),
          const Icon(
            color: TheColors.errorColor,
            Icons.arrow_drop_down,
            size: 18, // smaller size to match text
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "បុគ្គលិក"),
        backgroundColor: TheColors.bgColor,

        body: RefreshIndicator(
          onRefresh: () async {
            searchController.clear();
            employeecontroller.searchQuery.value = '';
            selectbranchid.value = null;
            selectroleid.value = null;
            currentstate.value = null;
            selectshiftid.value = null;
            await employeecontroller.fetchemployee();
            await rolecontroller.fetchrole();
            await branchcontroller.fetchbranch();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 55,
                          child: CustomTextField(
                            controller: searchController,
                            hintText: "ស្វែងរក".tr,
                            prefixIcon: Icons.search,
                            onChanged: (value) =>
                                employeecontroller.searchQuery.value = value,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 11, right: 11),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 3,
                                  ), // very tight
                                  minimumSize: Size(
                                    0,
                                    0,
                                  ), // remove default min size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // remove extra tap padding
                                  side: BorderSide(
                                    color: TheColors.errorColor,
                                    width: 0.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  showBranchSelectorSheet(
                                    context: context,
                                    branch: branchcontroller.branch,
                                    selectedBranchId: selectbranchid.value,
                                    onSelected: (id) {
                                      setState(() {
                                        selectbranchid.value = id;
                                        employeecontroller.fetchemployee(
                                          branchid: selectbranchid.value,
                                        );
                                        shiftcontroller.fetchshift(
                                          selectbranchid.value,
                                        );
                                      });
                                    },
                                  );
                                },
                                child: _buildlabel("សាខា"),
                              ),
                              SizedBox(width: 3),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 3,
                                  ), // very tight
                                  minimumSize: Size(
                                    0,
                                    0,
                                  ), // remove default min size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // remove extra tap padding
                                  side: BorderSide(
                                    color: TheColors.errorColor,
                                    width: 0.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  showRoleSelectorsheet(
                                    context: context,
                                    role: rolecontroller.role,
                                    selectedSelectId: selectroleid.value,
                                    onSelected: (id) {
                                      setState(() {
                                        selectroleid.value = id;
                                        employeecontroller.fetchemployee(
                                          roleid: selectroleid.value,
                                        );
                                      });
                                    },
                                  );
                                },
                                child: _buildlabel("តួនាទី"),
                              ),
                              SizedBox(width: 3),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 3,
                                  ), // very tight
                                  minimumSize: Size(
                                    0,
                                    0,
                                  ), // remove default min size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // remove extra tap padding
                                  side: BorderSide(
                                    color: TheColors.errorColor,
                                    width: 0.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  showIsActiveSelectorSheet(
                                    context: context,
                                    selectedValue:
                                        currentstate.value, // e.g. 1 or 0
                                    onSelected: (value) {
                                      setState(() {
                                        currentstate.value = value;
                                        employeecontroller.fetchemployee(
                                          isActive: currentstate.value!,
                                        );
                                      });
                                    },
                                  );
                                },
                                child: _buildlabel("ស្ថានភាព"),
                              ),
                              SizedBox(width: 3),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 3,
                                  ), // very tight
                                  minimumSize: Size(
                                    0,
                                    0,
                                  ), // remove default min size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // remove extra tap padding
                                  side: BorderSide(
                                    color: TheColors.errorColor,
                                    width: 0.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  showshiftbuttonsheet(
                                    context: context,
                                    shift: shiftcontroller.shift,
                                    selectedShiftId: selectshiftid.value,
                                    onSelected: (id) {
                                      setState(() {
                                        selectshiftid.value = id;
                                        employeecontroller.fetchemployee(
                                          shiftid: selectshiftid.value,
                                        );
                                      });
                                    },
                                  );
                                },
                                child: _buildlabel("វេនការងារ"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (employeecontroller.isLoading.value) {
                      return const CustomLoading();
                    }

                    if (employeecontroller.employees.isEmpty) {
                      return Center(
                        child: Text(
                          'អត់ទាន់មានបុគ្គលិក',
                          style: TextStyles.siemreap(context, fontSize: 12),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: employeecontroller.employees.length,
                      itemBuilder: (context, index) {
                        final employee = employeecontroller.employees[index];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: CustomEmployeeCard(
                              profileImage: employee.profileImage!,
                              basesalary: employee.baseSalary!,
                              start_time: employee.startTime!,
                              end_time: employee.endTime!,
                              shiftname: employee.shiftName,
                              namekh: employee.name ?? "អត់មាន",
                              role: employee.roleName ?? "អត់មាន".tr,
                              nameenglish: employee.nameEn ?? "",
                              branchname: employee.branchName,
                              isActive: employee.isActive,
                              onEdit: () {
                                Get.to(
                                  () => Updateemployeeview(
                                    employeemodel: employee,
                                  ),
                                  transition: Transition.rightToLeft,

                                  binding: Updateemployeebinding(),
                                );
                              },
                              onDelete: () {
                                employeecontroller.changestatusemployee(
                                  employee.id,
                                );
                              },
                              onTap: () => _handleViewEmployee(employee),
                              onchangeshift: () {
                                Get.bottomSheet(
                                  Employeeshifteditview(
                                    employeeId:
                                        employee.id!, // pass your employee id
                                    employeeShiftId: employee
                                        .employeeShitfId, // if you have one
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                );
                              },
                              chnagesalary: () {
                                Get.bottomSheet(
                                  EditSalaryView(salaryID: employee.salaryId!),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                );
                              },
                              increasesalry: () {
                                Get.bottomSheet(
                                   isScrollControlled: true,
                                  Increasesalaryview(
                                    employeeId: employee.id!,
                                    employeeShiftId: employee.employeeShitfId,
                                    salaryID: employee.salaryId,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                );
                              },
                            ),
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
}
