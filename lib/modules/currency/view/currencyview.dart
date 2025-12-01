import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/currencymodel.dart';
import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/currencycard.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class CurrencyView extends StatelessWidget {
  final controller = Get.find<Currencycontroller>();

  CurrencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "រូបបិយ្យប័ណ្ណ"),
      body: RefreshIndicator(
        onRefresh: ()async{
          await controller.fetchcurrency();
        },
        child: Obx(() {
          if (controller.isLoading.value && controller.currency.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
        
          if (controller.currency.isEmpty) {
            return Center(
              child: Text(
                'No currencies found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
        
          return _buildCurrencyList();
        }),
      ),
      floatingActionButton: CustomFloatingActionButton(
        backgroundColor: TheColors.errorColor,
        onPressed: (){
        _showAddCurrencyDialog(context);
      }),
    );
    
  }

  Widget _buildCurrencyList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [

          // Currency list
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.currency.length,
              itemBuilder: (context, index) {
                final currency = controller.currency[index];
                return CurrencyCard(
                  currency: currency,
                  onTap: () => _showCurrencyActions(context, currency),
                  backgroundColor: currency.isActive == true 
                      ? null 
                      : Colors.grey.withOpacity(0.1),
                );
              },
            )),
          ),
        ],
      ),
    );
  }


  void _showCurrencyActions(BuildContext context, Data currency) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('កែប្រែរូបិយប័ណ្ណ',style: TextStyles.siemreap(context),),
              onTap: () {
                Get.back();
                _showEditCurrencyDialog(context, currency);
              },
            ),
            ListTile(
              leading: Icon(
                currency.isActive == true ? Icons.toggle_on : Icons.toggle_off,
                color: currency.isActive == true ? Colors.green : Colors.red,
              ),
              title: Text(currency.isActive == true ? 'បិទ' : 'បេីក',style: TextStyles.siemreap(context),),
              onTap: () {
                Get.back();
                _showToggleStatusConfirmation(currency);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title: Text('មេីលលំអិត',style: TextStyles.siemreap(context),),
              onTap: () {
                Get.back();
                _showCurrencyDetails(currency);
              },
            ),
          ],
        ),
      ),
    );
  }

void _showAddCurrencyDialog(BuildContext context) {
  final codeController = TextEditingController();
  final symbolController = TextEditingController();
  final nameController = TextEditingController();

  Get.dialog(
    AlertDialog(
      title: Center(
        child: Text('បន្ថែមរូបបិយ្យប័ណ្ណ',
          style: TextStyles.siemreap(context, fontSize: 13),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: codeController,
            hintText: "លេខកូដ",
            prefixIcon: Icons.sign_language,
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: symbolController,
            hintText: "និមិត្តសញ្ញា",
            prefixIcon: Icons.monetization_on_rounded,
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: nameController,
            hintText: "ឈ្មោះ",
            prefixIcon: Icons.near_me,
          ),
        ],
      ),
      actions: [
        CustomElevatedButton(
          text: "បង្កេីតថ្មី",
          onPressed: () async {
            final code = codeController.text.trim();
            final symbol = symbolController.text.trim();
            final name = nameController.text.trim();

            if (code.isEmpty) {
              Get.snackbar("កំហុស", "សូមបញ្ចូល លេខកូដ",
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }

            if (symbol.isEmpty) {
              Get.snackbar("កំហុស", "សូមបញ្ចូល និមិត្តសញ្ញា",
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }

            if (name.isEmpty) {
              Get.snackbar("កំហុស", "សូមបញ្ចូល ឈ្មោះ",
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }

            controller.createcurrency(
              code: code,
              symbol: symbol,
              name: name,
            );

            Get.back(); // close dialog
          },
        )
      ],
    ),
  );
}


  void _showEditCurrencyDialog(BuildContext context, Data currency) {
    final codeController = TextEditingController(text: currency.code);
    final symbolController = TextEditingController(text: currency.symbol);
    final nameController = TextEditingController(text: currency.name);

    Get.dialog(
      AlertDialog(
        title: Text('កែប្រែរូបិយប័ណ្ណ',style:TextStyles.siemreap(context,),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: codeController, 
              hintText: "លេខកូដរុបិយប័ណ្ណ", 
              prefixIcon: Icons.currency_exchange),
            SizedBox(height: 12),
          CustomTextField(
              controller: symbolController, 
              hintText: "និមិត្តសញ្ញារូបិយប័ណ្ណ", 
              prefixIcon: Icons.attach_money),
            SizedBox(height: 12),

            CustomTextField(
              controller: nameController, 
              hintText: "ឈ្មោះ", 
              prefixIcon: Icons.badge),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('ថយក្រោយ',style: TextStyles.siemreap(context),),
          ),
          Obx(() => ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () {
                    if (codeController.text.isNotEmpty &&
                        symbolController.text.isNotEmpty &&
                        nameController.text.isNotEmpty) {
                      controller.updatecurrency(
                        code: codeController.text,
                        symbol: symbolController.text,
                        name: nameController.text,
                        currencyID: currency.id!,
                      );
                    } else {
                      CustomSnackbar.error(
                        title: "មានបញ្ហា", 
                        message: "Please fill all fields"
                      );
                    }
                  },
            child: controller.isLoading.value
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('កែប្រែ',style: TextStyles.siemreap(context),),
          )),
        ],
      ),
    );
  }

  void _showToggleStatusConfirmation(Data currency) {
    Get.dialog(
      AlertDialog(
        title: Text('Confirm Status Change'),
        content: Text(
          'Are you sure you want to ${currency.isActive == true ? 'deactivate' : 'activate'} ${currency.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.changestatuscurrency(currencyID: currency.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: currency.isActive == true ? Colors.red : Colors.green,
            ),
            child: Text(
              currency.isActive == true ? 'Deactivate' : 'Activate',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showCurrencyDetails(Data currency) {
    Get.dialog(
      AlertDialog(
        title: Text('Currency Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Code:', currency.code ?? 'N/A'),
            _buildDetailRow('Symbol:', currency.symbol ?? 'N/A'),
            _buildDetailRow('Name:', currency.name ?? 'N/A'),
            _buildDetailRow('Status:', 
              currency.isActive == true ? 'Active' : 'Inactive',
            ),
            _buildDetailRow('ID:', currency.id?.toString() ?? 'N/A'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _handleFilterSelection(String value) {
    // Implement filter logic based on your needs
    switch (value) {
      case 'active':
        // Filter active currencies
        break;
      case 'inactive':
        // Filter inactive currencies
        break;
      case 'all':
      default:
        // Show all currencies
        break;
    }
  }
}

// Alternative Grid View
class CurrencyGridView extends StatelessWidget {
  final Currencycontroller controller = Get.find<Currencycontroller>();

  CurrencyGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currencies - Grid View'),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.currency.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: controller.currency.length,
            itemBuilder: (context, index) {
              final currency = controller.currency[index];
              return CurrencyCard(
                currency: currency,
                onTap: () => _showCurrencyActions(context, currency),
                showDetails: false,
                elevation: 3,
              );
            },
          ),
        );
      }),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  void _showCurrencyActions(BuildContext context, Data currency) {
    // Same as above
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('Edit Currency'),
              onTap: () {
                Get.back();
                // Show edit dialog
              },
            ),
            // ... other actions
          ],
        ),
      ),
    );
  }
}