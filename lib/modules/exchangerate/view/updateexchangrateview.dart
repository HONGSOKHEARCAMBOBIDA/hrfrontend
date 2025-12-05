import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_currencypair_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/exchangeratemodel.dart';
import 'package:flutter_application_10/modules/currencypair/controller/currencypaircontroller.dart';
import 'package:flutter_application_10/modules/exchangerate/controller/exchangratecontroller.dart';
import 'package:flutter_application_10/modules/main/mainview/a.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class Updateexchangrateview extends StatefulWidget {
  final Data exchangerate;

  const Updateexchangrateview({super.key, required this.exchangerate});

  @override
  State<Updateexchangrateview> createState() => _UpdateexchangrateviewState();
}

class _UpdateexchangrateviewState extends State<Updateexchangrateview> {
  final exchangratecontroller = Get.find<Exchangratecontroller>();
  final currencypaircontroller = Get.find<Currencypaircontroller>();
  final _formkey = GlobalKey<FormState>();

  final ratecontroller = TextEditingController();

  final selectpairID = Rxn<int>();
  var selectpairName = "ជ្រើសរើសការប្ដូរប្រាក់".obs;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    final data = widget.exchangerate;

    // Set initial rate
    ratecontroller.text = data.rate!.toString();

    // Set initial selected pair
    selectpairID.value = data.pairId;

    final pair = currencypaircontroller.currencypair.firstWhereOrNull(
      (p) => p.id == data.pairId,
    );

    if (pair != null) {
      selectpairName.value =
          "${pair.baseCurrencyName} -> ${pair.targetCurrencyName}";
    }
  }

  Future<void> updateExchangerate() async {
    if (_formkey.currentState!.validate()) {
      try {
        final rateValue = double.tryParse(ratecontroller.text.trim());

        await exchangratecontroller.updateexchangerate(
          ID: widget.exchangerate.id!,
          pairID: selectpairID.value!,
          rate: rateValue!,
        );

        CustomSnackbar.success(
          title: "ធ្វើបច្ចុប្បន្នភាពជោគជ័យ",
          message: "អត្រាប្តូរប្រាក់ត្រូវបានកែប្រែ",
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
      appBar: CustomAppBar(title: "កែប្រែអត្រាប្ដូរប្រាក់"),
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
                      currencypair: currencypaircontroller.currencypair,
                      selectedCurrencypair: selectpairID.value,
                      onSelected: (id) {
                        selectpairID.value = id;
                        final pair = currencypaircontroller.currencypair
                            .firstWhere((p) => p.id == id);
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
                text: "កែប្រែ",
                onPressed: updateExchangerate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
