import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_currencypair_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/modules/currencypair/controller/currencypaircontroller.dart';
import 'package:flutter_application_10/modules/exchangerate/controller/exchangratecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Createexchangrateview extends StatefulWidget {
  const Createexchangrateview({super.key});

  @override
  State<Createexchangrateview> createState() => _CreateexchangrateviewState();
}

class _CreateexchangrateviewState extends State<Createexchangrateview> {
  final exchangratecontroller = Get.find<Exchangratecontroller>();
  final currencypaircontroler = Get.find<Currencypaircontroller>();
  final _formkey = GlobalKey<FormState>();

  final ratecontroller = TextEditingController();

  final selectpairID = Rxn<int>();
  var selectpairName = "ជ្រើសរើសការប្ដូរប្រាក់".obs;

  Future<void> createexchangrate() async {
    if (_formkey.currentState!.validate()) {
      if (selectpairID.value == null || ratecontroller.text.isEmpty) {
        CustomSnackbar.error(
          title: "បញ្ចូលមិនពេញលេញ",
          message: "សូមបញ្ចូលព័ត៌មានឲ្យបានពេញលេញ",
        );
        return;
      }

      try {
        final ratevalue = double.tryParse(ratecontroller.text.trim());

        await exchangratecontroller.createexchangerate(
          pairID: selectpairID.value!,
          rate: ratevalue!,
        );
      } catch (e) {
        CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      }
    }
  }

  @override
  void dispose() {
    ratecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បន្ថែមអត្រាប្ដូរប្រាក់"),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Obx(
                () => CustomOutlinedButton(
                  alignment: MainAxisAlignment.center,
                  text: selectpairName.value,
                  onPressed: () {
                    showcurrencypair(
                      context: context,
                      currencypair: currencypaircontroler.currencypair,
                      selectedCurrencypair: selectpairID.value,
                      onSelected: (id) {
                        selectpairID.value = id;

                        final pair = currencypaircontroler.currencypair
                            .firstWhere((p) => p.id == id);

                        // 🔥 FIXED HERE
                        selectpairName.value =
                            "${pair.baseCurrencyName} -> ${pair.targetCurrencyName}";
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: ratecontroller,
                hintText: "ឧ. 4000",
                prefixIcon: Icons.currency_exchange,
              ),

              const SizedBox(height: 20),

              CustomElevatedButton(
                text: "បង្កេីតថ្មី",
                onPressed: createexchangrate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
