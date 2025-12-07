import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/branchmodel.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/role/roleview/createroleview.dart';
import 'package:flutter_application_10/modules/role/roleview/roleassignpermissionview.dart';
import 'package:flutter_application_10/modules/role/roleview/rolepermissionfordelete.dart';
import 'package:flutter_application_10/shared/widgets/MapPickerView.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/branchcard.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customrolecard.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Branchview extends StatefulWidget {
  Branchview({super.key});

  @override
  State<Branchview> createState() => _BranchviewState();
}

class _BranchviewState extends State<Branchview> {
  final branchcontroller = Get.find<Branchcontroller>();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "សាខា"),
      body: RefreshIndicator(
           color: TheColors.errorColor,
          backgroundColor: TheColors.bgColor,
        onRefresh: () async {
          await branchcontroller.fetchbranch();

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (branchcontroller.isLoading.value) {
                    return const CustomLoading();
                  }

                  if (branchcontroller.branch.isEmpty) {
                    return Center(
                      child: Text(
                        "អត់មានទិន្ន័យ",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: branchcontroller.branch.length,
                    itemBuilder: (context, index) {
                      final branch = branchcontroller.branch[index];
                      return Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 2),
                              child: CustomBranchcard(
                                
                               isActive: branch.isActive,
                                name: branch.name ?? "អត់មាន",
                                latitube: branch.latitude!,
                                longitude: branch.longitude!,
                                radius: branch.radius!,
                                onEdit: () {
                                  showUpdateBranchBottomSheet(branch);
                                },
                                onDelete: () {
                                  branchcontroller.changestatusbranch(branchid: branch.id!);
                                },

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 85,
                             
                              ),
                              child: Divider(
                                color: TheColors.gray,
                                thickness: 0.3,
                              ),
                            ),
                          ],
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
      floatingActionButton: CustomFloatingActionButton(
        backgroundColor: TheColors.errorColor,
        heroTag: "gotocreaterole",
        onPressed: () {
          // Navigate to create department page
          showCreateBranchBottomSheet();
        },

        
      ),
    );
  }
void showUpdateBranchBottomSheet(Data branch) {
  final nameController = TextEditingController(text: branch.name);
  final radiusController = TextEditingController(text: branch.radius?.toString() ?? '');

  // Use RxDouble instead of RxnDouble for better reactivity
  final selectedLat = (branch.latitude ?? 0.0).obs;
  final selectedLng = (branch.longitude ?? 0.0).obs;

  Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        height: Get.height * 0.7,
     
        decoration: const BoxDecoration(
          color: TheColors.bgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 13),
            child: Column(
              children: [
                Container(
                   margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: TheColors.orange, width: 0.4),
            
                          borderRadius: BorderRadius.circular(12),
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "កែប្រែសាខា",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 18,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height:10),
                      Text("ឈ្មោះសាខា", style: TextStyles.siemreap(context, fontSize: 12)),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: nameController,
                        prefixIcon: Icons.business,
                        hintText: "ឈ្មោះសាខា (ឧទាហរណ៍៖ សាខា Toul Kork)",
                        validator: (value) => value == null || value.isEmpty ? 'សូមបញ្ចូលឈ្មោះសាខា' : null,
                      ),
                      const SizedBox(height: 15),
                      Text("ទីតាំងសាខា", style: TextStyles.siemreap(context, fontSize: 12)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return Text(
                                (selectedLat.value != 0.0 && selectedLng.value != 0.0)
                                    ? "Lat: ${selectedLat.value.toStringAsFixed(5)}, Lng: ${selectedLng.value.toStringAsFixed(5)}"
                                    : "មិនទាន់ជ្រើសទីតាំង",
                                style: TextStyles.siemreap(context, fontSize: 12, color: TheColors.gray),
                              );
                            }),
                          ),
                          IconButton(
                            onPressed: () async {
                              final result = await Get.to(() => MapPickerView());
                              if (result != null) {
                                selectedLat.value = result['lat'];
                                selectedLng.value = result['lng'];
                                print("Updated location: ${selectedLat.value}, ${selectedLng.value}"); // Debug print
                              }
                            },
                            icon: const Icon(
                              Icons.location_on,
                              color: TheColors.secondaryColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text("ចម្ថាយដែលអាចស្កែនបាន (m)", style: TextStyles.siemreap(context, fontSize: 12)),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: radiusController,
                        prefixIcon: Icons.circle_outlined,
                        hintText: "សូមបញ្ចូលចម្ថាយដែលអាចស្កែនបាន (ឧទាហរណ៍៖ 20)",
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'សូមបញ្ចូល' : null,
                      ),
                      const SizedBox(height: 15),
                
                    ],
                  ),
                ),
                      CustomElevatedButton(
                        text: "រក្សាទុក",
                        onPressed: () async {
                          final double? radius = double.tryParse(radiusController.text.trim());
                          if (formkey.currentState!.validate()) {
                            if (selectedLat.value == 0.0 || selectedLng.value == 0.0) {
                              Get.snackbar("កំហុស", "សូមជ្រើសទីតាំងសាខា");
                              return;
                            }
                  
                            if (radius == null) {
                              Get.snackbar("កំហុស", "សូមបញ្ចូលចម្ងាយដែលត្រឹមត្រូវ");
                              return;
                            }
                  
                            await branchcontroller.updatebranch(
                              branchid: branch.id!,
                              name: nameController.text,
                              latitude: selectedLat.value,
                              longitude: selectedLng.value,
                              radius: radius,
                            );
                  
                        
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
  );
}
void showCreateBranchBottomSheet() {
  final nameController = TextEditingController();
  final radiusController = TextEditingController();

  // Reactive variables for latitude and longitude
  final selectedLat = RxnDouble();
  final selectedLng = RxnDouble();

  Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        height: Get.height * 0.7,
       
        decoration: const BoxDecoration(
          color: TheColors.bgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 14),
            child: Column(
              children: [
                Container(
                   margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.only(left: 14,right: 14,top: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: TheColors.orange, width: 0.4),
              
                            borderRadius: BorderRadius.circular(12),
                          ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "បង្កើតសាខាថ្មី",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 18,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                  
                      // Branch name
                      Text("ឈ្មោះសាខា", style: TextStyles.siemreap(context, fontSize: 12)),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: nameController,
                        prefixIcon: Icons.business,
                        hintText: "ឈ្មោះសាខា (ឧទាហរណ៍៖ សាខា Toul Kork)",
                        validator: (value) =>
                            value == null || value.isEmpty ? 'សូមបញ្ចូលឈ្មោះសាខា' : null,
                      ),
                  
                      const SizedBox(height: 15),
                  
                      // Branch location
                      Text("ទីតាំងសាខា", style: TextStyles.siemreap(context, fontSize: 12)),
                      const SizedBox(height: 8),
                  
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return Text(
                                (selectedLat.value != null && selectedLng.value != null)
                                    ? "Lat: ${selectedLat.value!.toStringAsFixed(5)}, Lng: ${selectedLng.value!.toStringAsFixed(5)}"
                                    : "មិនទាន់ជ្រើសទីតាំង",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 12,
                                  color: TheColors.gray,
                                ),
                              );
                            }),
                          ),
                          IconButton(
                            onPressed: () async {
                              final result = await Get.to(() => MapPickerView());
                              if (result != null) {
                                selectedLat.value = result['lat'];
                                selectedLng.value = result['lng'];
                              }
                            },
                            icon: const Icon(
                              Icons.location_on,
                              color: TheColors.secondaryColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                  
                      const SizedBox(height: 15),
                  
                      // Radius
                      Text("ចម្ថាយដែលអាចស្កែនបាន (m)",
                          style: TextStyles.siemreap(context, fontSize: 12)),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: radiusController,
                        prefixIcon: Icons.circle_outlined,
                        hintText: "សូមបញ្ចូលចម្ថាយ (ឧទាហរណ៍៖ 20)",
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'សូមបញ្ចូល' : null,
                      ),
                  
                      const SizedBox(height: 15),
                  
                      // Save button
                 
                    ],
                  ),
                ),
                     CustomElevatedButton(
                        text: "រក្សាទុក",
                        onPressed: () async {
                          final int? radius = int.tryParse(radiusController.text.trim());
                          if (formkey.currentState!.validate()) {
                            if (selectedLat.value == null || selectedLng.value == null) {
                              Get.snackbar("កំហុស", "សូមជ្រើសទីតាំងសាខា");
                              return;
                            }
                  
                            await branchcontroller.createbranch(
                              name: nameController.text.trim(),
                              latitude: selectedLat.value!,
                              longitude: selectedLng.value!,
                              radius: radius!,
                            );
                  
                           
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
  );
}



}
