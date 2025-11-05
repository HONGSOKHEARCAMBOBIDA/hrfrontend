import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final Authcontroller controller = Get.find<Authcontroller>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
             
               
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextField(
                                controller: phoneController,
                                hintText: "លេខទូរសព្ទ",
                                prefixIcon: Icons.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "សូមបញ្ចូលលេខទូរសព្ទ";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextField(
                                controller: passwordController,
                                hintText: "លេខកូដ",
                                
                                prefixIcon: Icons.lock,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "សូមបញ្ចូលលេខកូដ";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return CustomElevatedButton(
                                        text: controller.isLoading.value
                                            ? "កំពុងភ្ជាប់..."
                                            : "ចូល",
                                        onPressed: controller.isLoading.value
                                            ? () {} // Empty function to prevent null error
                                            : () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  controller.login(
                                                    phone: phoneController.text,
                                                    password:
                                                        passwordController.text,
                                                  );
                                                }
                                              },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
