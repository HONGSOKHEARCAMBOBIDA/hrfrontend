import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_10/core/helper/show_communce_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_district_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_province_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_village_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/userregistermodel.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/communce/communcecontroller/communcecontroller.dart';
import 'package:flutter_application_10/modules/district/districtcontroller/districtcontroller.dart';
import 'package:flutter_application_10/modules/province/provincecontroller/provincecontroller.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/modules/village/villagecontroller/villagecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customdatepicker.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/number_symbols_data.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  final authcontroller = Get.find<Authcontroller>();
  final provincecontroller = Get.find<Provincecontroller>();
  final districtcontroller = Get.find<Districtcontroller>();
  final commmuncecontroller = Get.find<Communcecontroller>();
  final villagecontroller = Get.find<Villagecontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final shiftcontroller = Get.find<Shiftcontroller>();
  final _formkey = GlobalKey<FormState>();
  final selectbranchid = Rxn<int>();
  final namekhcontroller = TextEditingController();
  final nameencontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final selectgender = Rxn<int>();
  final selectdob = Rxn<DateTime>();
  final selecttype = Rxn<int>();
  final contactcontroller = TextEditingController();
  final nationalidnumbercontroller = TextEditingController();
  final selectvillageid = Rxn<int>();
  final selectprovinceid = Rxn<int>();
  final selectdistrictid = Rxn<int>();
  final selectcommunceid = Rxn<int>();
  final selectroleid = Rxn<int>();
  final selectshiftid = Rxn<int>();
  final selecthiredate = Rxn<DateTime>();
  final basesalarycontroller = TextEditingController();
  final workeddaycontroller = TextEditingController();

  var selectedProvinceName = "ជ្រើសរើសខេត្ត".obs;
  var selectedDistrictName = "ជ្រើសរើសស្រុក".obs;
  var selectedCommunceName = "ជ្រើសរើសឃុំ".obs;
  var selectedVillageName = "ជ្រើសរើសភូមី".obs;
  final List<Map<String, dynamic>> genders = [
    {"id": 1, "name": "ប្រុស"}, // Male
    {"id": 2, "name": "ស្រី"}, // Female
    {"id": 3, "name": "ផ្សេងទៀត"}, // Other
  ];
    final List<Map<String, dynamic>> types = [
    {"id": 1, "name": "Part Time"}, // Male
    {"id": 2, "name": "Full Time"}, // Female
   
  ];
  void clearForm() {
    selecttype.value = null;
    selectbranchid.value = null;
    namekhcontroller.clear();
    nameencontroller.clear();
    usernamecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    selectgender.value = null;
    selectdob.value = null;
    contactcontroller.clear();
    nationalidnumbercontroller.clear();
    selectvillageid.value = null;
    selectroleid.value = null;
    selecthiredate.value = null;
    selectshiftid.value = null;
    basesalarycontroller.clear();
    workeddaycontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    namekhcontroller.dispose();
    nameencontroller.dispose();
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    contactcontroller.dispose();
    nationalidnumbercontroller.dispose();
    basesalarycontroller.dispose();
    workeddaycontroller.dispose();
    super.dispose();
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 12)),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildHeader(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.siemreap(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: TheColors.black,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "បង្កេីតអ្នកប្រេីប្រាស់"),
      body: Obx(() {
        if (authcontroller.isLoading.value) {
          return CustomLoading();
        }
        return RefreshIndicator(
          onRefresh: () async {
            provincecontroller.provinces.clear();
            districtcontroller.district.clear();
            commmuncecontroller.communce.clear();
            villagecontroller.village.clear();
            provincecontroller.fetchprovince();
            branchcontroller.branch.clear();
            branchcontroller.fetchbranch();
            rolecontroller.role.clear();
            rolecontroller.fetchrole();
            shiftcontroller.shift.clear();
            shiftcontroller.fetchshift(null);
            selectedProvinceName.value = "ជ្រើសរើសខេត្ត";
                                                      selectedDistrictName.value =
                                              "ជ្រើសរើសស្រុក";
                                          selectcommunceid.value = null;
                                          selectedCommunceName.value =
                                              "ជ្រើសរើសឃុំ";
                                          selectvillageid.value = null;
                                          selectedVillageName.value =
                                              "ជ្រើសរើសភូមី";

          },
          child: GestureDetector(
              onTap: () {
    FocusScope.of(context).unfocus();
  },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
            
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader("ព័ត៌មានផ្ទាល់ខ្លួន"),
                      SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          _buildLabel("ឈ្មោះភាសាខ្មែរ"),
                          CustomTextField(
                            controller: namekhcontroller,
                            hintText: "ឧ. ហុង សុខហ៊ា",
                            prefixIcon: Icons.person_outlined,
                          ),
                          SizedBox(height: 8),
                          _buildLabel("ឈ្មោះអង់គ្លេស"),
                          CustomTextField(
                            controller: nameencontroller,
                            hintText: "HONG SOKHEAR",
                            prefixIcon: Icons.person_outlined,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("ភេទ"),
                                    Obx(
                                      () => DropdownButtonFormField<int>(
                                        value: selectgender.value,
                                        decoration: InputDecoration(
                                          labelText: "ភេទ",
                                          labelStyle: TextStyles.siemreap(
                                            context,
                                            fontSize: 12,
                                          ),
            
                                          // Border when focused
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  TheColors.orange, // change here
                                              width: 0.5,
                                            ),
                                          ),
                                          // Optional: Border when error
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            borderSide: BorderSide(
                                              color: TheColors.errorColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: TheColors.orange,
                                              width: 0.5,
                                            ),
            
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
            
                                        items: genders.map((gender) {
                                          return DropdownMenuItem<int>(
                                            value: gender['id'] as int,
                                            child: Text(
                                              gender['name'],
                                              style: TextStyles.siemreap(
                                                context,
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (Value) {
                                          selectgender.value = Value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("ថ្ងៃ-ខែ-ឆ្នាំ កំណេីត"),
                                    CustomDatePickerField(
                                      label: "",
                                      selectedDate: selectdob,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
            
                          SizedBox(height: 15),
                          _buildLabel("លេខអត្តសញ្ញាណប័ណ្ណ"),
                          CustomTextField(
                            controller: nationalidnumbercontroller,
                            hintText: "A123456",
                            prefixIcon: Icons.credit_card,
                          ),
                          SizedBox(height: 8),
                          _buildLabel("លេខទូរសព្ទ"),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: contactcontroller,
                            hintText: "070366214",
                            prefixIcon: Icons.phone_callback,
                          ),
                          SizedBox(height: 8),
                          _buildLabel("ទីកន្លែងរស់នៅ"),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomOutlinedButton(
                                      text: selectedProvinceName.value,
                                      onPressed: () {
                                        showProvinceSelectorSheet(
                                          context: context,
                                          provinces: provincecontroller.provinces,
                                          onSelected: (id) {
                                            selectprovinceid.value = id;
                                            selectedProvinceName.value =
                                                provincecontroller.provinces
                                                    .firstWhere((p) => p.id == id)
                                                    .name!;
                                            selectdistrictid.value = null;
                                            selectedDistrictName.value =
                                                "ជ្រើសរើសស្រុក";
                                            selectcommunceid.value = null;
                                            selectedCommunceName.value =
                                                "ជ្រើសរើសឃុំ";
                                            selectvillageid.value = null;
                                            selectedVillageName.value =
                                                "ជ្រើសរើសភូមី";
                                            districtcontroller.district.clear();
                                            commmuncecontroller.communce.clear();
                                            villagecontroller.village.clear();
                                            districtcontroller.fetchdistrict(id);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 5),
            
                                  Expanded(
                                    child: CustomOutlinedButton(
                                      text: selectedDistrictName.value,
                                      onPressed: () {
                                        showDistrictSelectorSheet(
                                          context: context,
                                          district: districtcontroller.district,
                                          onSelected: (id) {
                                            selectdistrictid.value = id;
                                            selectedDistrictName.value =
                                                districtcontroller.district
                                                    .firstWhere((p) => p.id == id)
                                                    .name!;
                                            selectcommunceid.value = null;
                                            selectedCommunceName.value =
                                                "ជ្រើសរើសឃុំ";
                                            selectvillageid.value = null;
                                            selectedVillageName.value =
                                                "ជ្រើសរើសភូមី";
                                            commmuncecontroller.communce.clear();
                                            commmuncecontroller.fetchcommunce(id);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomOutlinedButton(
                                      text: selectedCommunceName.value,
                                      onPressed: () {
                                        showCommunceSelectorSheet(
                                          context: context,
                                          communce: commmuncecontroller.communce,
                                          onSelected: (id) {
                                            selectcommunceid.value = id;
                                            selectedCommunceName.value =
                                                commmuncecontroller.communce
                                                    .firstWhere((p) => p.id == id)
                                                    .name!;
                                            selectvillageid.value = null;
                                            selectedVillageName.value =
                                                "ជ្រើសរើសភូមី";
                                            villagecontroller.village.clear();
                                            villagecontroller.fetvillage(id);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: CustomOutlinedButton(
                                      text: selectedVillageName.value,
                                      onPressed: () {
                                        showVillageSelectorsheet(
                                          context: context,
                                          village: villagecontroller.village,
                                          onSelected: (id) {
                                            selectvillageid.value = id;
                                            selectedVillageName.value =
                                                villagecontroller.village
                                                    .firstWhere((p) => p.id == id)
                                                    .name!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      _buildHeader("ប្រាក់ខែ & ការងារ"),
            
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("សាខា"),
            
                          CustomDropdown(
                            selectedValue: selectbranchid,
                            items: branchcontroller.branch,
                            hintText: "រេីសសាខា",
                            onChanged: (Value) {
                              selectbranchid.value = Value;
                              shiftcontroller.fetchshift(selectbranchid.value);
                            },
                          ),
                          SizedBox(height: 8),
                          _buildLabel("តួនាទី"),
                          CustomDropdown(
                            selectedValue: selectroleid,
                            items: rolecontroller.role,
                            hintText: "រេីសតួនាទី",
                            onChanged: (Value) {
                              selectroleid.value = Value;
                            },
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("ថ្ងៃចូលបម្រេីការងារ"),
                                    CustomDatePickerField(
                                      label: "",
                                      selectedDate: selecthiredate,
                                    ),
                                  ],
                                ),
                              ),
            
                              SizedBox(width: 10),
            
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("ចំនួនថ្ងៃធ្វេីការ"),
                                    CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: workeddaycontroller,
                                      hintText: "30",
                                      prefixIcon: Icons.lock_clock_rounded,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("ប្រាក់ខែ"),
                                    CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: basesalarycontroller,
                                      hintText: "300",
                                      prefixIcon: Icons.attach_money,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
            
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("ម៉ោងធ្វេីការ"),
                                    CustomDropdown(
                                      selectedValue: selectshiftid,
                                      items: shiftcontroller.shift,
                                      hintText: "វេនព្រឹក",
                                      onChanged: (Value) {
                                        selectshiftid.value = Value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            _buildLabel("ប្រភេទការងារ"),
                                                            Obx(
                                                              () => DropdownButtonFormField<int>(
                                                                value: selecttype.value,
                                                                decoration: InputDecoration(
                                                                  labelText: "ប្រភេទការងារ",
                                                                  labelStyle: TextStyles.siemreap(
                                                                    context,
                                                                    fontSize: 12,
                                                                  ),
                                                                    
                                                                  // Border when focused
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                          TheColors.orange, // change here
                                                                      width: 0.5,
                                                                    ),
                                                                  ),
                                                                  // Optional: Border when error
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                    borderSide: BorderSide(
                                                                      color: TheColors.errorColor,
                                                                      width: 0.5,
                                                                    ),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: TheColors.orange,
                                                                      width: 0.5,
                                                                    ),
                                                                    
                                                                    borderRadius: BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                    
                                                                items: types.map((typework) {
                                                                  return DropdownMenuItem<int>(
                                                                    value: typework['id'] as int,
                                                                    child: Text(
                                                                      typework['name'],
                                                                      style: TextStyles.siemreap(
                                                                        context,
                                                                        fontSize: 12,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (Value) {
                                                                  selecttype.value = Value;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                        ],
                      ),
                      SizedBox(height: 5),
                      _buildHeader("ព័ត៌មានរបស់ System"),
            
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("ឈ្មោះសម្រាប់ចូលប្រព័ន្ធ"),
                          CustomTextField(
                            controller: usernamecontroller,
                            hintText: "hongsokhear",
                            prefixIcon: Icons.person,
                          ),
                          SizedBox(height: 8),
                          _buildLabel("អ៊ីម៉ែល"),
                          CustomTextField(
                            controller: emailcontroller,
                            hintText: "hongsokhear@gmail.com",
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(height: 8),
                          _buildLabel("លេខសម្ងាត់"),
                          CustomTextField(
                            controller: passwordcontroller,
                            hintText: "123456",
                            prefixIcon: Icons.remove_red_eye,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNav(
        title: "បង្កេីត",
        onTap: () async {
      
          if (_formkey.currentState!.validate()) {
            if (selectbranchid.value == null ||
                selectgender.value == null ||
                selectdob.value == null ||
                selectvillageid.value == null ||
                selectroleid.value == null ||
                selecthiredate.value == null) {
              CustomSnackbar.error(
                title: "បញ្ចូលមិនពេញលេញ",
                message: "សូមបញ្ចូលព័ត៌មានឲ្យបានពេញលេញ!",
              );
              return;
            }

            final user = UserRegisterModel(
              branchID: selectbranchid.value!,
              nameEn: nameencontroller.text.trim(),
              nameKh: namekhcontroller.text.trim(),
              username: usernamecontroller.text.trim(),
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim(),
              gender: selectgender.value!,
              contact: contactcontroller.text.trim(),
              nationalIdNumber: nationalidnumbercontroller.text.trim(),
              dob: selectdob.value!,
              villageId: selectvillageid.value!,
              roleId: selectroleid.value!,
              shiftId: selectshiftid.value!,
              hireDate: selecthiredate.value!,
              type: selecttype.value!, // or your default type value
              baseSalary: int.tryParse(basesalarycontroller.text) ?? 0,
              workedDay: int.tryParse(workeddaycontroller.text) ?? 0,
            );

            await authcontroller.register(user);
            clearForm();
          }
        },
      ),
    );
  }
}
