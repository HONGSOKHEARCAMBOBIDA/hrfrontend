import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/rolemodel.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Createroleview extends StatefulWidget {
  const Createroleview({super.key});

  @override
  State<Createroleview> createState() => _CreateroleviewState();
}

class _CreateroleviewState extends State<Createroleview> {
  final controller = Get.find<Rolecontroller>();

  final formkey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();
  final displaynamecontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    displaynamecontroller.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(title: "បង្កើតតួនាទីថ្មី"),
    backgroundColor: TheColors.bgColor,
    body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // ❌ No need for Obx here — form doesn’t depend on Rx variable
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.4),

                        borderRadius: BorderRadius.circular(12),
                      ),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ឈ្មោះ",
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 12,
                      color: TheColors.gray,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: namecontroller,
                    hintText: 'ឈ្មោះតួនាទី (ឧទាហរណ៍: Teller)',
                    prefixIcon: Icons.business,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'សូមបំពេញឈ្មោះតួនាទី';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "ឈ្មោះបង្ហាញ",
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 12,
                      color: TheColors.gray,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: displaynamecontroller,
                    hintText: 'ពិពណ៌នាឈ្មោះតួនាទី (ឧទាហរណ៍: បេឡា)',
                    prefixIcon: Icons.description,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'សូមបំពេញការពិពណ៌នា';
                      }
                      return null;
                    },
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    ),

    // ✅ Only wrap this with Obx
    bottomNavigationBar: Obx(() {
      return CustomBottomNav(
        title: controller.isLoading.value ? "កំពុងបង្កើត..." : "បង្កើតថ្មី",
        onTap: controller.isLoading.value
            ? null
            : () async {
                if (formkey.currentState!.validate()) {
                  final role = Data(
                    name: namecontroller.text.trim(),
                    displayName: displaynamecontroller.text.trim(),
                  );
                  await controller.createrole(role);
                }
              },
      );
    }),
  );
}

}
