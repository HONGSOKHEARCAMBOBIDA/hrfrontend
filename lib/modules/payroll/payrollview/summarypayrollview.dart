import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/showcurrencyselector.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/payrollrequestmodel.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:flutter_application_10/modules/payroll/payrollcontroller/payrollcontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/payrolldraffcard.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Summarypayrollview extends StatefulWidget {
  const Summarypayrollview({super.key});

  @override
  State<Summarypayrollview> createState() => _SummarypayrollviewState();
}

class _SummarypayrollviewState extends State<Summarypayrollview> {
  final paycontroller = Get.find<Payrollcontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final currencycontroller = Get.find<Currencycontroller>();
  final selectbranchid = Rxn<int>();
  final selectmonth = Rxn<int>();
  final selectcurrencyID = Rxn<int>();
  final searchcontroller = TextEditingController();
 final Map<int, double> loanDeductions = {};
  // Month list with Khmer and English names
  final List<Map<String, dynamic>> months = [
    {'id': 1, 'name': 'មករា', 'name_en': 'January'},
    {'id': 2, 'name': 'កុម្ភៈ', 'name_en': 'February'},
    {'id': 3, 'name': 'មីនា', 'name_en': 'March'},
    {'id': 4, 'name': 'មេសា', 'name_en': 'April'},
    {'id': 5, 'name': 'ឧសភា', 'name_en': 'May'},
    {'id': 6, 'name': 'មិថុនា', 'name_en': 'June'},
    {'id': 7, 'name': 'កក្កដា', 'name_en': 'July'},
    {'id': 8, 'name': 'សីហា', 'name_en': 'August'},
    {'id': 9, 'name': 'កញ្ញា', 'name_en': 'September'},
    {'id': 10, 'name': 'តុលា', 'name_en': 'October'},
    {'id': 11, 'name': 'វិច្ឆិកា', 'name_en': 'November'},
    {'id': 12, 'name': 'ធ្នូ', 'name_en': 'December'},
  ];


  @override
  void initState() {
    super.initState();
    // Set current month as default
    selectmonth.value = DateTime.now().month;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    searchcontroller.dispose();
    super.dispose();
  }

    void _onLoanDeductionChanged(double amount, int salaryId) {
    loanDeductions[salaryId] = amount;
  }
  void _submitAllPayrolls() {
    if (selectbranchid.value == null || selectmonth.value == null) {
      Get.snackbar(
        'ការជ្រើសរើស',
        'សូមជ្រើសរើសសាខា និងខែជាមុនសិន',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (paycontroller.payrolldraff.isEmpty) {
      Get.snackbar(
        'ទិន្នន័យ',
        'មិនមានទិន្នន័យប្រាក់ខែដេីម្បីបញ្ជូនទេ',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: Text('បញ្ជូនប្រាក់ខែ', style: TextStyles.siemreap(context)),
        content: Text(
          'តើអ្នកពិតជាចង់បញ្ជូនប្រាក់ខែទាំងអស់នេះមែនទេ?បញ្ជួនហេីយមិនអាចកែប្រែបានទេ!',
          style: TextStyles.siemreap(context, fontSize: 14),
        ),
        actions: [

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TheColors.errorColor,
                  ),
                  onPressed: () {
                  
                    paycontroller.submitAllPayrolls(
                      currencyId: selectcurrencyID.value!,
                      month: selectmonth.value!,
                      branchId: selectbranchid.value!,
                      loanDeductions: loanDeductions,
                    );
                    Get.back();
                  },
                  child: Text('បញ្ជូន', style: TextStyles.siemreap(context, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // Method to show month selector bottom sheet
  void _showMonthSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: TheColors.bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ជ្រើសរើសខែ',
                style: TextStyles.siemreap(
                  context, 
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    final month = months[index];
                    final isSelected = selectmonth.value == month['id'];
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectmonth.value = month['id'];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? TheColors.errorColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: TheColors.orange,width: 0.5
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              month['name'],
                              style: TextStyles.siemreap(
                                context,
                                fontSize: 14,
                                color: isSelected ? Colors.white : Colors.black87,
                                fontweight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              month['name_en'],
                              style: TextStyles.siemreap(
                                context,
                                fontSize: 10,
                                color: TheColors.errorColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TheColors.errorColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'បិទ',
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បេីកប្រាក់ខែ"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildFilters(context),
            const SizedBox(height: 10),
            Expanded(child: _buildpayrolldraffList(context)),
            SizedBox(height: 15,),
              _buildSubmitButton(),
          ],
        ),
      ),

    );
  }

  ButtonStyle _filterStyle() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: const BorderSide(color: TheColors.errorColor, width: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
    Widget _buildSubmitButton() {
    return Obx(() {
      if (paycontroller.payrolldraff.isEmpty) return SizedBox();
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomElevatedButton(
          onPressed: paycontroller.isSubmitting.value ? null : _submitAllPayrolls,
          backgroundColor: TheColors.errorColor,
          text:"បញ្ចូនទាំងអស់" 
        ),
      );
    });
  }


  Widget _buildFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Column(
        children: [
          CustomTextField(
            controller: searchcontroller, 
            hintText: "ស្វែករកដោយឈ្មោះ", 
            prefixIcon: Icons.search),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Branch Button
                        Expanded(
                child: TextButton(
                  style: _filterStyle(),
                  onPressed: () {
                    showcurrencyselector(
                      context: context,
                      currency: currencycontroller.currency,
                      selectedCurrencyId: selectcurrencyID.value,
                      onSelected: (id) {
                        setState(() {
                          selectcurrencyID.value = id;
                        });
                      },
                    );
                  },
                  child: _buildCurrencyLabel(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextButton(
                  style: _filterStyle(),
                  onPressed: () {
                    showBranchSelectorSheet(
                      context: context,
                      branch: branchcontroller.branch,
                      selectedBranchId: selectbranchid.value,
                      onSelected: (id) {
                        setState(() {
                          selectbranchid.value = id;
                        });
                      },
                    );
                  },
                  child: _buildBranchLabel(),
                ),
              ),
              const SizedBox(width: 8),
              
              // Month Button
              Expanded(
                child: TextButton(
                  style: _filterStyle(),
                  onPressed: () {
                    _showMonthSelector(context);
                  },
                  child: _buildMonthLabel(),
                ),
              ),
              const SizedBox(width: 8),
              
              // Generate Button
              Expanded(
                child: TextButton(
                  style: _filterStyle(),
                  onPressed: () {
                    if (selectbranchid.value == null || selectmonth.value == null) {
                      // Show error message if branch or month is not selected
                      Get.snackbar(
                        'ការជ្រើសរើស',
                        'សូមជ្រើសរើសសាខា និងខែជាមុនសិន',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    paycontroller.fetchdraffpayroll(
                      currencyID: selectcurrencyID.value!,
                      branchid: selectbranchid.value!, 
                      month: selectmonth.value!,
                      name: searchcontroller.text
                    );
                  },
                  child: _buildGenerateLabel(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildBranchLabel() {
  final selectedBranch = selectbranchid.value;

  final branchName = selectedBranch != null
      ? branchcontroller.branch
          .firstWhere(
            (p) => p.id == selectedBranch,
          
          )
          ?.name ?? 'សាខា'
      : 'សាខា';

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        branchName,
        style: TextStyles.siemreap(context, fontSize: 10),
      ),
      const Icon(
        Icons.arrow_drop_down,
        color: TheColors.errorColor,
        size: 18,
      ),
    ],
  );
}

Widget _buildCurrencyLabel() {
  final selectedCurrency = selectcurrencyID.value;

  final currencyName = selectedCurrency != null
      ? currencycontroller.currency
          .firstWhere(
            (p) => p.id == selectedCurrency,
           
          )
          ?.name ?? 'រូបិយប័ណ្ណ'
      : 'រូបិយប័ណ្ណ';

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        currencyName,
        style: TextStyles.siemreap(context, fontSize: 10),
      ),
      const Icon(
        Icons.arrow_drop_down,
        color: TheColors.errorColor,
        size: 18,
      ),
    ],
  );
}


  Widget _buildMonthLabel() {
    final selectedMonth = selectmonth.value;
    final monthName = selectedMonth != null 
        ? months.firstWhere(
            (month) => month['id'] == selectedMonth,
            orElse: () => {'name': 'ខែ', 'name_en': 'Month'},
          )['name']
        : 'ខែ';

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          monthName,
          style: TextStyles.siemreap(context, fontSize: 10),
        ),
        const Icon(
          Icons.arrow_drop_down,
          color: TheColors.errorColor,
          size: 18,
        ),
      ],
    );
  }

  Widget _buildGenerateLabel() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "បង្កើត",
          style: TextStyles.siemreap(context, fontSize: 10),
        ),
      ],
    );
  }
  Widget _buildpayrolldraffList(BuildContext context) {
    return Obx(() {
      if (paycontroller.isLoading.value) return const CustomLoading();

      if (paycontroller.payrolldraff.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'អត់ទាន់មានទិន្ន័យ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              const SizedBox(height: 8),
              if (selectbranchid.value == null || selectmonth.value == null)
                Text(
                  'សូមជ្រើសរើសសាខា និងខែជាមុន',
                  style: TextStyles.siemreap(context, fontSize: 10, color: Colors.grey),
                ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: paycontroller.payrolldraff.length,
        itemBuilder: (context, index) {
          final payroll = paycontroller.payrolldraff[index];
          return PayrollCard(
            payrollData: payroll,
            onLoanDeductionChanged: _onLoanDeductionChanged, // Pass the callback
          );
        },
      );
    });
  }

}