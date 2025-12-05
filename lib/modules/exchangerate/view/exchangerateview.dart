import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/currencypair/binding/currencypairbinding.dart';
import 'package:flutter_application_10/modules/exchangerate/controller/exchangratecontroller.dart';
import 'package:flutter_application_10/modules/exchangerate/view/createexchangrateview.dart';
import 'package:flutter_application_10/modules/exchangerate/view/updateexchangrateview.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/exchangeratecard.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:get/get.dart';
class Exchangerateview extends StatefulWidget {
  const Exchangerateview({super.key});

  @override
  State<Exchangerateview> createState() => _ExchangerateviewState();
}

class _ExchangerateviewState extends State<Exchangerateview> {
  final exchangratecontroller = Get.find<Exchangratecontroller>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "អត្រាប្ដូរប្រាក់"),
      body: RefreshIndicator(
           color: TheColors.errorColor,
          backgroundColor: TheColors.bgColor,
        onRefresh: ()async {
          await exchangratecontroller.fetchexchangrate();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                    child: Obx(() {
                      if (exchangratecontroller.isLoading.value) {
                        return const CustomLoading();
                      }
        
                      if (exchangratecontroller.exchangerate.isEmpty) {
                        return Center(
                          child: Text(
                            'អត់ទាន់មានអ្នកប្រេីប្រាស់',
                            style: TextStyles.siemreap(context,fontSize: 12),
                          ),
                        );
                      }
        
                      return ListView.builder(
                        itemCount: exchangratecontroller.exchangerate.length,
                        itemBuilder: (context, index) {
                          final excharate = exchangratecontroller.exchangerate[index];
                          return Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: 
                                  ExchangeRateCard(
                                    isActive: excharate.isActive,
                                    rate: excharate.rate!,
                                    baseCurrencyCode: excharate.baseCurrencyCode!,
                                    baseCurrencySymbol: excharate.baseCurrencySymbol!,
                                    baseCurrencyName: excharate.baseCurrencyName!,
                                    targetCurrencyCode: excharate.targetCurrencyCode!,
                                    targetCurrencySymbol: excharate.targetCurrencySymbol!,
                                    targetCurrencyName: excharate.targetCurrencyName!,
                                    createByName: excharate.createByName!,
                                    updateByName: excharate.updateByName!,
                                    onEdit: () {
                                      Get.to(
                                        () => Updateexchangrateview(exchangerate: excharate),
                                        binding: Currencypairbinding(),
                                        transition: Transition.rightToLeft,
                                      );
                                    },

                                    onToggleStatus: ()async{
                                      await exchangratecontroller.changestatusexchangerate(ID: excharate.id!);
                                    },
                                    
                                    )
                                ),
                                                            Padding(
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  right: 32
                               
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
          ],),
      ),
      floatingActionButton: CustomFloatingActionButton(onPressed: (){
        Get.to(()=>Createexchangrateview(),transition: Transition.rightToLeft,binding: Currencypairbinding());
      },backgroundColor: TheColors.errorColor,),
    );
  }
}