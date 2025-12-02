import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:get/get.dart';

class Employeeshifteditview extends StatefulWidget {
  final Data employeemodel;
  final int employeeId;
  final int? employeeShiftId;

  const Employeeshifteditview({
    Key? key,
    required this.employeemodel,
    required this.employeeId,
    this.employeeShiftId,
  }) : super(key: key);

  @override
  State<Employeeshifteditview> createState() => _EmployeeshifteditviewState();
}

class _EmployeeshifteditviewState extends State<Employeeshifteditview> {
  final branchcontroller = Get.find<Branchcontroller>();
  final shiftcontroller = Get.find<Shiftcontroller>();
  final employeecontroller = Get.find<Employeecontroller>();

  final selectbranchid = Rxn<int>();
  final selectshiftid = Rxn<int>();
      @override
  void initState() {
    super.initState();
    _initializeData();

  }
void _initializeData() {
  final employee = widget.employeemodel;

  selectbranchid.value = employee.branchshiftId!;
  selectshiftid.value = employee.shiftId!;

  // fetch shift of that branch
  shiftcontroller.shift.clear();
  shiftcontroller.fetchshift(selectbranchid.value);
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Text("សាខា", style: TextStyles.siemreap(context, fontSize: 12)),
                    const SizedBox(height: 5),
                    CustomDropdown(
                      selectedValue: selectbranchid,
                      items: branchcontroller.branch,
                      hintText: "រេីសសាខា",
                      onChanged: (value) {
                        selectbranchid.value = value;
                        shiftcontroller.shift.clear();
                        shiftcontroller.fetchshift(selectbranchid.value);
                      },
                    ),
                    const SizedBox(height: 10),
                    Text("វេនការងារ", style: TextStyles.siemreap(context, fontSize: 12)),
                    const SizedBox(height: 5),
                    CustomDropdown(
                      
                      selectedValue: selectshiftid,
                      items: shiftcontroller.shift,
                      hintText: "វេនការងារ",
                      onChanged: (value) {
                        selectshiftid.value = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: "កែប្រែ",
                      onPressed: () async {
                        if (selectbranchid.value == null || selectshiftid.value == null) {
                          Get.snackbar("សូមជ្រើសរើស", "សាខា និង វេនការងារ");
                          return;
                        }
          
                        await employeecontroller.changeshift(
                          
                          employeeID: widget.employeeId,
                          shiftID: selectshiftid.value!,
                         
                          employeeshiftid: widget.employeeShiftId,
                        );
                        
                      
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
