import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/rolepermissioncard.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Roleassignpermissionview extends StatefulWidget {
  const Roleassignpermissionview({super.key});

  @override
  State<Roleassignpermissionview> createState() =>
      _RoleassignpermissionviewState();
}

class _RoleassignpermissionviewState extends State<Roleassignpermissionview> {
  final controller = Get.find<Rolecontroller>();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int roleid = Get.arguments as int;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchroleassignpermission(roleid);
    });

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បន្ថែមសិទ្ធ"),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchroleassignpermission(roleid);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

             
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: SizedBox(
                  height: 50,
                  child: CustomTextField(
                    controller: searchController, 
                    hintText: "ស្វែងរក", 
                    prefixIcon: Icons.search,
                    onChanged: (Value)=>controller.searchQuery.value = Value,),
                ),
              ),

              const SizedBox(height: 10),

              // 🧩 Permission List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CustomLoading();
                  }

                  final filteredList = controller.filteredPermissions;

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text('រកមិនឃើញទិន្នន័យ'),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final permission = filteredList[index];
                      return RolePermissionCard(
                        permission: permission,
                        onChanged: (value) {
                          permission.assigned = value;
                          controller.roleassingpermission[index] = permission;

                          final permissionId = permission.id!;
                          if (controller.changedPermissionIds
                              .contains(permissionId)) {
                            controller.changedPermissionIds.remove(permissionId);
                          } else {
                            controller.changedPermissionIds.add(permissionId);
                          }
                        },
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomBottomNav(
          title: "បន្ថែម",
          onTap: () async {
            controller.saveRolePermissions(roleid);
          },
        ),
      ),
    );
  }
}
