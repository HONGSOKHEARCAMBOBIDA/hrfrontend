import 'package:flutter/material.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:get/get.dart';

class b extends GetView<MainController> {
  const b({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "b"),
      body: Center(child: Column(
        children: [
          Text("b"),
         ElevatedButton(
          onPressed: controller.logout, 
          child: Text("logout"))
        ],
      ),),
    );
  }
}