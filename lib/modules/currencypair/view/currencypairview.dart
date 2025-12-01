import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/currencypair/controller/currencypaircontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/currencypaircard.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:get/get.dart';

class Currencypairview extends StatelessWidget {
  final controller = Get.find<Currencypaircontroller>();
  Currencypairview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "ការប្ដូប្រាក់"),
      body: RefreshIndicator(
        onRefresh: ()async{
          await controller.fetchcurrencypair();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return CustomLoading();
          }
          if (controller.currencypair.isEmpty) {
            return Center(
              child: Text(
                "គ្មានទិន្ន័យ",
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
            );
          }
          return buildlist();
        }),
      ),
    );
  }

  Widget buildlist() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.currencypair.length,
                itemBuilder: (context, index) {
                  final currency = controller.currencypair[index];
                  return CurrencyPairCard(currencyPair: currency);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
