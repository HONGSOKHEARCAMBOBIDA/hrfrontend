import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveTypeController extends GetxController {
  var isPermission = 0.obs;
  var isWithoutPermission = 0.obs;
  var isWeekend = 0.obs;

  void updateSelection(String type) {
    if (type == 'permission') {
      isPermission.value = 1;
      isWithoutPermission.value = 0;
      isWeekend.value = 0;
    } else if (type == 'withoutpermission') {
      isPermission.value = 0;
      isWithoutPermission.value = 1;
      isWeekend.value = 0;
    } else if (type == 'weekend') {
      isPermission.value = 0;
      isWithoutPermission.value = 0;
      isWeekend.value = 1;
    }
  }
}

class LeaveTypeCard extends StatelessWidget {
  final LeaveTypeController controller = Get.put(LeaveTypeController());

  LeaveTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: TheColors.orange,width: 0.5),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ប្រភេទការឈប់សម្រាក",
                style: TextStyles.siemreap(context,fontSize: 14,fontweight: FontWeight.bold)
              ),
              const Divider(height: 24,color: TheColors.errorColor,),
        
              // Permission
              Obx(() => Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: controller.isPermission.value,
                        onChanged: (_) =>
                            controller.updateSelection('permission'),
                        activeColor: TheColors.successColor,
                      ),
                      Text("មានការអនុញ្ញាត",
                          style: TextStyles.siemreap(context,fontSize: 11,fontweight: FontWeight.bold)),
                    ],
                  )),
        
              // Without Permission
              Obx(() => Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: controller.isWithoutPermission.value,
                        onChanged: (_) =>
                            controller.updateSelection('withoutpermission'),
                        activeColor: TheColors.secondaryColor,
                      ),
                      Text("គ្មានការអនុញ្ញាត",
                            style: TextStyles.siemreap(context,fontSize: 11,fontweight: FontWeight.bold)),
                    ],
                  )),
        
              // Weekend
              Obx(() => Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: controller.isWeekend.value,
                        onChanged: (_) => controller.updateSelection('weekend'),
                        activeColor: TheColors.errorColor,
                      ),
                      Text("ថ្ងៃសុក្រ សៅរ៍",
                          style: TextStyles.siemreap(context,fontSize: 11,fontweight: FontWeight.bold)),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
