import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_communce_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_district_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_province_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_village_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/userupdatemodel.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/communce/communcecontroller/communcecontroller.dart';
import 'package:flutter_application_10/modules/district/districtcontroller/districtcontroller.dart';
import 'package:flutter_application_10/modules/province/provincecontroller/provincecontroller.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/village/villagecontroller/villagecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customdatepicker.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Updateuserview extends StatefulWidget {
  final dynamic userModel; // Use your actual user model type
  
  const Updateuserview({super.key, required this.userModel});

  @override
  State<Updateuserview> createState() => _UpdateuserviewState();
}

class _UpdateuserviewState extends State<Updateuserview> {
  final authcontroller = Get.find<Authcontroller>();
  final provincecontroller = Get.find<Provincecontroller>();
  final districtcontroller = Get.find<Districtcontroller>();
  final commmuncecontroller = Get.find<Communcecontroller>();
  final villagecontroller = Get.find<Villagecontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  
  final _formkey = GlobalKey<FormState>();
  final selectbranchid = Rxn<int>();
  final namekhcontroller = TextEditingController();
  final nameencontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final selectgender = Rxn<int>();
  final selectdob = Rxn<DateTime>();
  final contactcontroller = TextEditingController();
  final nationalidnumbercontroller = TextEditingController();
  final selectvillageid = Rxn<int>();
  final selectprovinceid = Rxn<int>();
  final selectdistrictid = Rxn<int>();
  final selectcommunceid = Rxn<int>();
  final selectroleid = Rxn<int>();

  var selectedProvinceName = "ជ្រើសរើសខេត្ត".obs;
  var selectedDistrictName = "ជ្រើសរើសស្រុក".obs;
  var selectedCommunceName = "ជ្រើសរើសឃុំ".obs;
  var selectedVillageName = "ជ្រើសរើសភូមី".obs;
  
  final List<Map<String, dynamic>> genders = [
    {"id": 1, "name": "ប្រុស"},
    {"id": 2, "name": "ស្រី"},
    {"id": 3, "name": "ផ្សេងទៀត"},
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _loadInitialData();
  }

  void _initializeData() {
    // Initialize controllers with existing data
    namekhcontroller.text = widget.userModel.name ?? "";
    nameencontroller.text = widget.userModel.nameEn ?? "";
    usernamecontroller.text = widget.userModel.username ?? "";
    emailcontroller.text = widget.userModel.email ?? "";
    contactcontroller.text = widget.userModel.contact ?? "";
    nationalidnumbercontroller.text = widget.userModel.nationalIdNumber ?? "";
    
    selectbranchid.value = widget.userModel.branchId;
    selectgender.value = widget.userModel.gender;
    selectroleid.value = widget.userModel.roleId;
    selectvillageid.value = widget.userModel.villageId;
    selectprovinceid.value = widget.userModel.provinceId;
    selectdistrictid.value = widget.userModel.districtId;
    selectcommunceid.value = widget.userModel.communeId;
    
    // Parse date
    if (widget.userModel.dob != null) {
      selectdob.value = _parseDate(widget.userModel.dob);
    }

    // Set location names if available
    if (widget.userModel.provinceName != null) {
      selectedProvinceName.value = widget.userModel.provinceName!;
    }
    if (widget.userModel.districtName != null) {
      selectedDistrictName.value = widget.userModel.districtName!;
    }
    if (widget.userModel.communeName != null) {
      selectedCommunceName.value = widget.userModel.communeName!;
    }
    if (widget.userModel.villageName != null) {
      selectedVillageName.value = widget.userModel.villageName!;
    }
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (_) {
      try {
        return DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateString, true).toLocal();
      } catch (_) {
        return null;
      }
    }
  }

  void _loadInitialData() {
    // Load initial data for dropdowns
    provincecontroller.fetchprovince();
    branchcontroller.fetchbranch();
    rolecontroller.fetchrole();

    // Load location data if IDs are available
    if (widget.userModel.provinceId != null) {
      districtcontroller.fetchdistrict(widget.userModel.provinceId!);
    }
    if (widget.userModel.districtId != null) {
      commmuncecontroller.fetchcommunce(widget.userModel.districtId!);
    }
    if (widget.userModel.communeId != null) {
      villagecontroller.fetvillage(widget.userModel.communeId!);
    }
  }

  Future<void> _updateUser() async {
    if (_formkey.currentState!.validate()) {
      if (selectbranchid.value == null ||
          selectgender.value == null ||
          selectdob.value == null ||
          selectvillageid.value == null ||
          selectroleid.value == null) {
        CustomSnackbar.error(
          title: "បញ្ចូលមិនពេញលេញ",
          message: "សូមបញ្ចូលព័ត៌មានឲ្យបានពេញលេញ!",
        );
        return;
      }

      final user = Userupdatemodel(
        ID: widget.userModel.id, // Make sure to include the user ID
        branchID: selectbranchid.value!,
        nameEn: nameencontroller.text.trim(),
        name: namekhcontroller.text.trim(),
        username: usernamecontroller.text.trim(),
        email: emailcontroller.text.trim(),
        gender: selectgender.value!,
        contact: contactcontroller.text.trim(),
        nationalIdNumber: nationalidnumbercontroller.text.trim(),
        dob: selectdob.value!,
        villageId: selectvillageid.value!,
        roleId: selectroleid.value!,
      );

      try {
        await authcontroller.updateuser(user);
        Get.back(); // Navigate back after successful update
      } catch (e) {
        CustomSnackbar.error(
          title: "កំហុស",
          message: "មិនអាចកែប្រែព័ត៌មានបាន: $e"
        );
      }
    }
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
  void dispose() {
    namekhcontroller.dispose();
    nameencontroller.dispose();
    usernamecontroller.dispose();
    emailcontroller.dispose();
    contactcontroller.dispose();
    nationalidnumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "កែប្រែព័ត៌មានអ្នកប្រើប្រាស់"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: TheColors.orange,
                                          width: 0.5,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                                        borderRadius: BorderRadius.circular(12),
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
                        keyboardType: TextInputType.phone,
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
                                child: Obx(
                                  ()=> CustomOutlinedButton(
                                    text: selectedProvinceName.value,
                                    onPressed: () {
                                      showProvinceSelectorSheet(
                                        context: context,
                                        provinces: provincecontroller.provinces,
                                        onSelected: (id) {
                                          selectprovinceid.value = id;
                                          selectedProvinceName.value ='';
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
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Obx(
                                   ()=> CustomOutlinedButton(
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
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                   ()=> CustomOutlinedButton(
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
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Obx(
                                   ()=> CustomOutlinedButton(
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildHeader("ព័ត៌មានការងារ"),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        title: "កែប្រែ",
        onTap: _updateUser,
      ),
    );
  }
}