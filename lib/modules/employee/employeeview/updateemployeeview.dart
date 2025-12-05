import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_communce_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_district_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_province_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_role_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_village_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/constants.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/communce/communcecontroller/communcecontroller.dart';
import 'package:flutter_application_10/modules/district/districtcontroller/districtcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
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

class Updateemployeeview extends StatefulWidget {
  final Data employeemodel; // Changed from EmployeeModel to Data

  const Updateemployeeview({super.key, required this.employeemodel});

  @override
  State<Updateemployeeview> createState() => _UpdateemployeeviewState();
}

class _UpdateemployeeviewState extends State<Updateemployeeview> {
  Rx<File?> newProfileImage = Rx<File?>(null);
  Rx<File?> newQrImage = Rx<File?>(null);
  String? profileImageUrl;
  String? qrImageUrl;
  final employeecontroller = Get.find<Employeecontroller>();
  final provincecontroller = Get.find<Provincecontroller>();
  final districtcontroller = Get.find<Districtcontroller>();
  final commmuncecontroller = Get.find<Communcecontroller>();
  final villagecontroller = Get.find<Villagecontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();

  final _formkey = GlobalKey<FormState>();
  final selecttype = Rxn<int>();
  final selectispromote = Rxn<bool>();
  final selecthiredate = Rxn<DateTime>();
  final selectbranchid = Rxn<int>();
  final namekhcontroller = TextEditingController();
  final nameencontroller = TextEditingController();
  final selectgender = Rxn<int>();
  final selectmaterialstatus = Rxn<int>();
  final selectpositionlevel = Rxn<int>();
  final selectdob = Rxn<DateTime>();
  final selectpromotedate = Rxn<DateTime>();
  final contactcontroller = TextEditingController();
  final familyphonecontroller = TextEditingController();
  final educationlevelcontroller = TextEditingController();
  final experienceyearcontroller = TextEditingController();
  final previouscompanycontroller = TextEditingController();
  final banknamecontroller = TextEditingController();
  final bankaccountcontroller = TextEditingController();
  final notecontroller = TextEditingController();
  final nationalidnumbercontroller = TextEditingController();

  final selectvillageidofbirth = Rxn<int>();
  final selectprovinceidofbirth = Rxn<int>();
  final selectdistrictidofbirth = Rxn<int>();
  final selectcommunceidofbirth = Rxn<int>();
  final selectvillageidofcurrenctadrress = Rxn<int>();
  final selectprovinceidofcurrenctadrress = Rxn<int>();
  final selectdistrictidofcurrenctadrress = Rxn<int>();
  final selectcommunceidofcurrenctadrress = Rxn<int>();
  final selectroleid = Rxn<int>();

  var selectedProvinceNameofbirth = "ជ្រើសរើសខេត្ត".obs;
  var selectedDistrictNameofbirth = "ជ្រើសរើសស្រុក".obs;
  var selectedCommunceNameofbirth = "ជ្រើសរើសឃុំ".obs;
  var selectedVillageNameofbirth = "ជ្រើសរើសភូមិ".obs;
  var selectedProvinceNameofcurrenctadrress = "ជ្រើសរើសខេត្ត".obs;
  var selectedDistrictNameofcurrenctadrress = "ជ្រើសរើសស្រុក".obs;
  var selectedCommunceNameofcurrenctadrress = "ជ្រើសរើសឃុំ".obs;
  var selectedVillageNameofcurrenctadrress = "ជ្រើសរើសភូមិ".obs;
  var selectedrolename = "រេីសតួនាទី".obs;
  var selectedbranchname = "រេីសសាខា".obs;
  final List<Map<String, dynamic>> genders = [
    {"id": 1, "name": "ប្រុស"},
    {"id": 2, "name": "ស្រី"},
    {"id": 3, "name": "ផ្សេងទៀត"},
  ];
  final List<Map<String, dynamic>> materialstatus = [
    {"id": 1, "name": "នៅលីវ"},
    {"id": 2, "name": "មានគ្រូសារ"},
    {"id": 3, "name": "ផ្សេងទៀត"},
  ];
  final List<Map<String, dynamic>> types = [
    {"id": 1, "name": "Part Time"},
    {"id": 2, "name": "Full Time"},
  ];
  final List<Map<String, dynamic>> positionLevel = [
    {"id": 1, "name": "បុគ្គលិកធម្មតា"},
    {"id": 2, "name": "បុគ្គលិកជំនាញ"},
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _loadInitialData();
  }

  void _initializeData() {
    // Initialize controllers with existing data
    final employee = widget.employeemodel;

    selectpositionlevel.value = employee.positionLevel!;
    selectispromote.value = employee.isPromote!;
    notecontroller.text = employee.notes!;
    bankaccountcontroller.text = employee.bankAccountNumber!;
    banknamecontroller.text = employee.bankName!;
    familyphonecontroller.text = employee.familyPhone!;
    educationlevelcontroller.text = employee.educationLevel!;
    experienceyearcontroller.text = employee.experienceYears.toString();
    namekhcontroller.text = employee.name ?? "";
    nameencontroller.text = employee.nameEn ?? "";
    contactcontroller.text = employee.contact ?? "";
    selectedrolename.value = employee.roleName ?? "";
    selectedbranchname.value = employee.branchName ?? "";
    previouscompanycontroller.text = employee.previousCompany!;
    nationalidnumbercontroller.text = employee.nationalIdNumber ?? "";
    selecttype.value = employee.type;
    selectbranchid.value = employee.branchId;
    selectgender.value = employee.gender;
    selectmaterialstatus.value = employee.maritalStatus;
    selectroleid.value = employee.roleId;

    // Birth location
    selectvillageidofbirth.value = employee.villageIdOfBirth;
    selectprovinceidofbirth.value = employee.provinceIdOfBirth;
    selectdistrictidofbirth.value = employee.districtIdOfBirth;
    selectcommunceidofbirth.value = employee.communceIdOfBirth;

    // Current address location
    selectvillageidofcurrenctadrress.value = employee.villageIdCurrentAddress;
    selectprovinceidofcurrenctadrress.value = employee.provinceIdCurrentAddress;
    selectdistrictidofcurrenctadrress.value = employee.districtIdCurrentAddress;
    selectcommunceidofcurrenctadrress.value = employee.communceIdCurrentAddress;

    // Parse dates
    if (employee.dateOfBirth != null) {
      selectdob.value = _parseDate(employee.dateOfBirth);
    }
    if (employee.hireDate != null) {
      selecthiredate.value = _parseDate(employee.hireDate);
    }
    if (employee.promoteDate != null) {
      selectpromotedate.value = _parseDate(employee.promoteDate);
    }

    // Set location names if available
    if (employee.provinceNameOfBirth != null) {
      selectedProvinceNameofbirth.value = employee.provinceNameOfBirth!;
    }
    if (employee.districtNameOfBirth != null) {
      selectedDistrictNameofbirth.value = employee.districtNameOfBirth!;
    }
    if (employee.communceNameOfBirth != null) {
      selectedCommunceNameofbirth.value = employee.communceNameOfBirth!;
    }
    if (employee.villageNameOfBirth != null) {
      selectedVillageNameofbirth.value = employee.villageNameOfBirth!;
    }

    if (employee.provinceNameCurrentAddress != null) {
      selectedProvinceNameofcurrenctadrress.value =
          employee.provinceNameCurrentAddress!;
    }
    if (employee.districtNameCurrentAddress != null) {
      selectedDistrictNameofcurrenctadrress.value =
          employee.districtNameCurrentAddress!;
    }
    if (employee.communceNameCurrentAddress != null) {
      selectedCommunceNameofcurrenctadrress.value =
          employee.communceNameCurrentAddress!;
    }
    if (employee.villageNameCurrentAddress != null) {
      selectedVillageNameofcurrenctadrress.value =
          employee.villageNameCurrentAddress!;
    }

    // Set profile image URL
    if (employee.profileImage != null) {
      profileImageUrl =
          "${Appconstants.baseUrl}/profileimage/${employee.profileImage}";
    }
    if (employee.qrCodeBankAccount != null) {
      qrImageUrl =
          "${Appconstants.baseUrl}/qrcodeimage/${employee.qrCodeBankAccount}";
    }
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (_) {
      try {
        return DateFormat(
          "yyyy-MM-dd'T'HH:mm:ssZ",
        ).parse(dateString, true).toLocal();
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

    // Load location data if IDs are available for birth location
    if (widget.employeemodel.provinceIdOfBirth != null) {
      districtcontroller.fetchdistrict(widget.employeemodel.provinceIdOfBirth!);
    }
    if (widget.employeemodel.districtIdOfBirth != null) {
      commmuncecontroller.fetchcommunce(
        widget.employeemodel.districtIdOfBirth!,
      );
    }
    if (widget.employeemodel.communceIdOfBirth != null) {
      villagecontroller.fetvillage(widget.employeemodel.communceIdOfBirth!);
    }

    // Load location data if IDs are available for current address
    if (widget.employeemodel.provinceIdCurrentAddress != null) {
      // You might need separate controllers for current address or reuse the same ones
      districtcontroller.fetchdistrict(
        widget.employeemodel.provinceIdCurrentAddress!,
      );
    }
    if (widget.employeemodel.districtIdCurrentAddress != null) {
      commmuncecontroller.fetchcommunce(
        widget.employeemodel.districtIdCurrentAddress!,
      );
    }
    if (widget.employeemodel.communceIdCurrentAddress != null) {
      villagecontroller.fetvillage(
        widget.employeemodel.communceIdCurrentAddress,
      );
    }
  }

  Future<void> updateEmployee() async {
    if (_formkey.currentState!.validate()) {
      // Validate required fields
      if (selectbranchid.value == null ||
          selectgender.value == null ||
          selectdob.value == null ||
          selectvillageidofbirth.value == null ||
          selectroleid.value == null ||
          selecttype.value == null ||
          selecthiredate.value == null) {
        CustomSnackbar.error(
          title: "បញ្ចូលមិនពេញលេញ",
          message: "សូមបញ្ចូលព័ត៌មានឲ្យបានពេញលេញ!",
        );
        return;
      }

      try {
        final year = int.tryParse(experienceyearcontroller.text);
        await employeecontroller.updateemployee(
          employeeID: widget.employeemodel.id!,
          branchID: selectbranchid.value!.toString(),
          nameEn: nameencontroller.text.trim(),
          nameKh: namekhcontroller.text.trim(),
          gender: selectgender.value!,
          contact: contactcontroller.text.trim(),

          nationalIdNumber: nationalidnumbercontroller.text.trim(),
          roleId: selectroleid.value!,
          hireDate: selecthiredate.value!,
          promoteDate: selectpromotedate
              .value!, // Using hire date as promote date if not available
          type: selecttype.value!,
          dateOfBirth: selectdob.value!,
          villageIdofbirth: selectvillageidofbirth.value!,
          materialstatus: selectmaterialstatus.value!, // Default value
          villageIdcurrentaddress: selectvillageidofcurrenctadrress.value!,
          familyPhone: familyphonecontroller.text,
          educationLevel: educationlevelcontroller.text,
          experienceYears: year!,
          previousCompany: previouscompanycontroller.text,
          bankName: banknamecontroller.text,
          bankAccountNumber: bankaccountcontroller.text,
          notes: notecontroller.text,
          positionLevel: selectpositionlevel.value!,
          profileImage: newProfileImage.value,
          qrcodeimage: newQrImage.value, // You can add QR code logic if needed
        );
      } catch (e) {
        CustomSnackbar.error(
          title: "កំហុស",
          message: "មិនអាចកែប្រែព័ត៌មានបាន: $e",
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

  Widget _buildHeader(String label,IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Icon(icon, color: TheColors.orange, size: 18),
          SizedBox(width: 6,),
          Text(
            label,
            style: GoogleFonts.siemreap(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: TheColors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    namekhcontroller.dispose();
    nameencontroller.dispose();
    contactcontroller.dispose();
    nationalidnumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "កែប្រែព័ត៌មានបុគ្គលិក"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image Section
                    Center(
                      child: Column(
                        children: [
                          Obx(() {
                            if (newProfileImage.value != null) {
                              return CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  newProfileImage.value!,
                                ),
                              );
                            } else if (profileImageUrl != null) {
                              return CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(profileImageUrl!),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 60,
                                child: Icon(Icons.person, size: 40),
                              );
                            }
                          }),
                          SizedBox(height: 10),
                          OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  color: TheColors.warningColor,
                                  width: 0.5,
                                ), // 👈 border color & width
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    9,
                                  ), // 👈 corner radius
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final image = await employeecontroller
                                  .pickProfile();
                              if (image != null) {
                                newProfileImage.value = image;
                              }
                            },
                            child: Text(
                              "ជ្រើសរើសរូបភាព",
                              style: TextStyles.siemreap(
                                context,
                                color: TheColors.orange,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader("ព័ត៍មានផ្ទាល់ខ្លួន",Icons.person),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: TheColors.orange,
                                                width: 0.5,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                dropdownColor: TheColors.bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: TheColors.orange,
                                                ),
                                                iconSize: 15,
                                                elevation: 2,
                                                menuMaxHeight: 180,
      
                                                // Button styling
                                                style: TextStyles.siemreap(
                                                  context,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("លេខអត្តសញ្ញាណប័ណ្ណ"),
                                      CustomTextField(
                                        controller: nationalidnumbercontroller,
                                        hintText: "A123456",
                                        prefixIcon: Icons.credit_card,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("លេខទូរសព្ទ"),
                                      CustomTextField(
                                        keyboardType: TextInputType.phone,
                                        controller: contactcontroller,
                                        hintText: "070366214",
                                        prefixIcon: Icons.phone_callback,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("ស្ថានភាពគ្រួសារ"),
                                Obx(
                                  () => DropdownButtonFormField<int>(
                                    value: selectgender.value,
                                    decoration: InputDecoration(
                                      labelText: "ស្ថានភាព",
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
                                    items: materialstatus.map((material) {
                                      return DropdownMenuItem<int>(
                                        value: material['id'] as int,
                                        child: Text(
                                          material['name'],
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
                                               dropdownColor: TheColors.bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: TheColors.orange,
                                                ),
                                                iconSize: 15,
                                                elevation: 2,
                                                menuMaxHeight: 180,
      
                                                // Button styling
                                                style: TextStyles.siemreap(
                                                  context,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _buildLabel("លេខទូរសព្ទគ្រូសារ"),
                            CustomTextField(
                              keyboardType: TextInputType.phone,
                              controller: familyphonecontroller,
                              hintText: "070366214",
                              prefixIcon: Icons.phone_callback,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader("ព័ត៌មានការងារ",Icons.work_outline),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("តួនាទី"),
                                // CustomDropdown(
                                //   selectedValue: selectroleid,
                                //   items: rolecontroller.role,
                                //   hintText: "រេីសតួនាទី",
                                //   onChanged: (Value) {
                                //     selectroleid.value = Value;
                                //   },
                                // ),
                                                                  Obx(
                                    () => CustomOutlinedButton(
                                      text: selectedrolename.value.isEmpty
                                          ? "រេីសតួនាទី"
                                          : selectedrolename.value,
                                      
                                      onPressed: () {
                                        showRoleSelectorsheet(
                                          context: context,
                                          role: rolecontroller.role,
                                          selectedSelectId: selectroleid.value,
                                          onSelected: (id) {
                                            selectroleid.value = id;
                                            selectedrolename.value =
                                                rolecontroller.role
                                                    .firstWhere((p) => p.id == id)
                                                    .displayName!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                SizedBox(height: 8),
                                _buildLabel("សាខា"),
                                // CustomDropdown(
                                //   selectedValue: selectbranchid,
                                //   items: branchcontroller.branch,
                                //   hintText: "រេីសសាខា",
                                //   onChanged: (Value) {
                                //     selectbranchid.value = Value;
                                //   },
                                // ),
                                                                  Obx(
                                    () => CustomOutlinedButton(
                                      text: selectedbranchname.value.isEmpty
                                          ? "រេីសសាខា"
                                          : selectedbranchname.value,
                                      onPressed: () {
                                        showBranchSelectorSheet(
                                          context: context,
                                          branch: branchcontroller.branch,
                                          selectedBranchId: selectbranchid.value,
                                          onSelected: (id) {
                                            selectbranchid.value = id;
                                            selectedbranchname.value =
                                                branchcontroller.branch
                                                    .firstWhere((p) => p.id == id)
                                                    .name!;
                                       
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                SizedBox(height: 8),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: TheColors.orange,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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
                                              dropdownColor: TheColors.bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: TheColors.orange,
                                                ),
                                                iconSize: 15,
                                                elevation: 2,
                                                menuMaxHeight: 180,
                                                
                                                
                                                // Button styling
                                                style: TextStyles.siemreap(
                                                  context,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel("ថ្ងៃត្រូវវាយតម្លៃ"),
                                          CustomDatePickerField(
                                            label: "",
                                            selectedDate: selectpromotedate,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel("វាយតម្លៃហេីយឬនៅ"),
                                          Padding(
                                            padding: const EdgeInsets.all(17.0),
                                            child: Container(
                                              child: Text(
                                                selectispromote == true
                                                    ? 'បានវាយតម្លៃ'
                                                    : 'មិនទាន់វាយតម្លៃ',
                                                style: TextStyles.siemreap(
                                                  context,
                                                  fontSize: 13,
                                                  fontweight: FontWeight.bold,
                                                  color: TheColors.orange,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                  SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("កម្រិតតួនាទី"),
                            Obx(
                              () => DropdownButtonFormField<int>(
                                value: selectpositionlevel.value,
                                decoration: InputDecoration(
                                  labelText: "កម្រិត",
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
                                items: positionLevel.map((position) {
                                  return DropdownMenuItem<int>(
                                    value: position['id'] as int,
                                    child: Text(
                                      position['name'],
                                      style: TextStyles.siemreap(
                                        context,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Value) {
                                  selectpositionlevel.value = Value;
                                },
                                                                               dropdownColor: TheColors.bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: TheColors.orange,
                                                ),
                                                iconSize: 15,
                                                elevation: 2,
                                                menuMaxHeight: 180,
      
                                                // Button styling
                                                style: TextStyles.siemreap(
                                                  context,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                              ),
                            ),
                          ],
                        ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader("ព័ត៌មានផ្នែកហិរញ្ញវត្ថុ",Icons.attach_money),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("កុងធនាគារដែលប្រេី"),
                                CustomTextField(
                               
                                  controller: banknamecontroller,
                                  hintText: "ABA",
                                  prefixIcon: Icons.credit_card,
                                ),
                                SizedBox(height: 8),
                                _buildLabel("លេខកុងធនាគារ"),
                                CustomTextField(
                                 
                                  controller: bankaccountcontroller,
                                  hintText: "A123",
                                  prefixIcon: Icons.account_circle,
                                ),
                                SizedBox(height: 8),
                                _buildLabel("QR Code"),
                                Obx(() {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ), // use 0 for perfect square
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            color: TheColors.orange,
                                            child: Image(
                                              image: newQrImage.value == null
                                                  ? NetworkImage(qrImageUrl!)
                                                  : FileImage(newQrImage.value!)
                                                        as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt_rounded,
                                            size: 30,
                                            color: TheColors.errorColor,
                                          ),
                                          onPressed: () async {
                                            File? pickedFile =
                                                await employeecontroller
                                                    .pickqrImage();
                                            if (pickedFile != null) {
                                              newQrImage.value =
                                                  pickedFile; // Sync the Rx variable
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader("ព័ត៌មានអប់រំ និងបទពិសោធន៍",Icons.school_outlined),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("កម្រិតសិក្សា"),
                                      CustomTextField(
                                      
                                        controller: educationlevelcontroller,
                                        hintText: "បរញ្ញាបត្រ",
                                        prefixIcon: Icons.menu_book,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("បទពិសោធន៍"),
                                      CustomTextField(
                                       
                                        controller: experienceyearcontroller,
                                        hintText: "2",
                                        prefixIcon: Icons.work_history,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _buildLabel("ក្រុមហ៊ុនពីមុន"),
                            CustomTextField(
                             
                              controller: previouscompanycontroller,
                              hintText: "ABA",
                              prefixIcon: Icons.apartment,
                            ),
                            SizedBox(height: 8,),
                            _buildLabel("សម្គាល់"),
                        CustomTextField(
                          
                          controller: notecontroller,
                          hintText: "..",
                          prefixIcon: Icons.sticky_note_2,
                        ),
                          ],
                        ),
                      ),
                    ),
                     SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          _buildHeader("ទីកន្លែងកំណើត",Icons.location_on_outlined),
                          SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                      alignment: MainAxisAlignment.center,
                                      text:
                                          selectedProvinceNameofbirth
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសខេត្ត"
                                          : selectedProvinceNameofbirth.value,
                                      onPressed: () {
                                        showProvinceSelectorSheet(
                                          context: context,
                                          provinces:
                                              provincecontroller.provinces,
                                          selectedProvince: selectprovinceidofbirth.value,
                                          onSelected: (id) {
                                            selectprovinceidofbirth.value = id;
                                            selectedProvinceNameofbirth
                                                .value = provincecontroller
                                                .provinces
                                                .firstWhere((p) => p.id == id)
                                                .name!;
                                            selectdistrictidofbirth.value =
                                                null;
                                            selectedDistrictNameofbirth.value =
                                                "ជ្រើសរើសស្រុក";
                                            selectcommunceidofbirth.value =
                                                null;
                                            selectedCommunceNameofbirth.value =
                                                "ជ្រើសរើសឃុំ";
                                            selectvillageidofbirth.value = null;
                                            selectedVillageNameofbirth.value =
                                                "ជ្រើសរើសភូមិ";
                                            districtcontroller.district.clear();
                                            commmuncecontroller.communce
                                                .clear();
                                            villagecontroller.village.clear();
                                            districtcontroller.fetchdistrict(
                                              id,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedDistrictNameofbirth
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសស្រុក"
                                          : selectedDistrictNameofbirth.value,
                                      onPressed:
                                          selectprovinceidofbirth.value == null
                                          ? null
                                          : () {
                                              showDistrictSelectorSheet(
                                                context: context,
                                                district:
                                                    districtcontroller.district,
                                                selecteddistrict: selectdistrictidofbirth.value,
                                                onSelected: (id) {
                                                  selectdistrictidofbirth
                                                          .value =
                                                      id;
                                                  selectedDistrictNameofbirth
                                                          .value =
                                                      districtcontroller
                                                          .district
                                                          .firstWhere(
                                                            (p) => p.id == id,
                                                          )
                                                          .name!;
                                                  selectcommunceidofbirth
                                                          .value =
                                                      null;
                                                  selectedCommunceNameofbirth
                                                          .value =
                                                      "ជ្រើសរើសឃុំ";
                                                  selectvillageidofbirth.value =
                                                      null;
                                                  selectedVillageNameofbirth
                                                          .value =
                                                      "ជ្រើសរើសភូមិ";
                                                  commmuncecontroller.communce
                                                      .clear();
                                                  commmuncecontroller
                                                      .fetchcommunce(id);
                                                },
                                              );
                                            },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                                 Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedCommunceNameofbirth
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសឃុំ"
                                          : selectedCommunceNameofbirth.value,
                                      onPressed:
                                          selectdistrictidofbirth.value == null
                                          ? null
                                          : () {
                                              showCommunceSelectorSheet(
                                                context: context,
                                                communce: commmuncecontroller
                                                    .communce,
                                                selectedCommunce: selectcommunceidofbirth.value,
                                                onSelected: (id) {
                                                  selectcommunceidofbirth
                                                          .value =
                                                      id;
                                                  selectedCommunceNameofbirth
                                                          .value =
                                                      commmuncecontroller
                                                          .communce
                                                          .firstWhere(
                                                            (p) => p.id == id,
                                                          )
                                                          .name!;
                                                  selectvillageidofbirth.value =
                                                      null;
                                                  selectedVillageNameofbirth
                                                          .value =
                                                      "ជ្រើសរើសភូមិ";
                                                  villagecontroller.village
                                                      .clear();
                                                  villagecontroller.fetvillage(
                                                    id,
                                                  );
                                                },
                                              );
                                            },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedVillageNameofbirth
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសភូមិ"
                                          : selectedVillageNameofbirth.value,
                                      onPressed:
                                          selectcommunceidofbirth.value == null
                                          ? null
                                          : () {
                                              showVillageSelectorsheet(
                                                context: context,
                                                village:
                                                    villagecontroller.village,
                                                selectedVillageId: selectvillageidofbirth.value,
                                                onSelected: (id) {
                                                  selectvillageidofbirth.value =
                                                      id;
                                                  selectedVillageNameofbirth
                                                      .value = villagecontroller
                                                      .village
                                                      .firstWhere(
                                                        (p) => p.id == id,
                                                      )
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
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                         decoration: BoxDecoration(
                        border: Border.all(color: TheColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          
                        
                            
                           
                       
                            _buildHeader("ទីកន្លែងបច្ចុប្ប័ន្ន",Icons.home_outlined),
                              SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedProvinceNameofcurrenctadrress
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសខេត្ត"
                                          : selectedProvinceNameofcurrenctadrress
                                                .value,
                                      onPressed: () {
                                        showProvinceSelectorSheet(
                                          context: context,
                                          provinces:
                                              provincecontroller.provinces,
                                          selectedProvince: selectprovinceidofcurrenctadrress.value,
                                          onSelected: (id) {
                                            selectprovinceidofcurrenctadrress
                                                    .value =
                                                id;
                                            selectedProvinceNameofcurrenctadrress
                                                .value = provincecontroller
                                                .provinces
                                                .firstWhere((p) => p.id == id)
                                                .name!;
                                            selectdistrictidofcurrenctadrress
                                                    .value =
                                                null;
                                            selectedDistrictNameofcurrenctadrress
                                                    .value =
                                                "ជ្រើសរើសស្រុក";
                                            selectcommunceidofcurrenctadrress
                                                    .value =
                                                null;
                                            selectedCommunceNameofcurrenctadrress
                                                    .value =
                                                "ជ្រើសរើសឃុំ";
                                            selectvillageidofcurrenctadrress
                                                    .value =
                                                null;
                                            selectedVillageNameofcurrenctadrress
                                                    .value =
                                                "ជ្រើសរើសភូមិ";
                                            districtcontroller.district.clear();
                                            commmuncecontroller.communce
                                                .clear();
                                            villagecontroller.village.clear();
                                            districtcontroller.fetchdistrict(
                                              id,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedDistrictNameofcurrenctadrress
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសស្រុក"
                                          : selectedDistrictNameofcurrenctadrress
                                                .value,
                                      onPressed:
                                          selectprovinceidofcurrenctadrress
                                                  .value ==
                                              null
                                          ? null
                                          : () {
                                              showDistrictSelectorSheet(
                                                context: context,
                                                district:
                                                    districtcontroller.district,
                                                selecteddistrict: selectdistrictidofcurrenctadrress.value,
                                                onSelected: (id) {
                                                  selectdistrictidofcurrenctadrress
                                                          .value =
                                                      id;
                                                  selectedDistrictNameofcurrenctadrress
                                                          .value =
                                                      districtcontroller
                                                          .district
                                                          .firstWhere(
                                                            (p) => p.id == id,
                                                          )
                                                          .name!;
                                                  selectcommunceidofcurrenctadrress
                                                          .value =
                                                      null;
                                                  selectedCommunceNameofcurrenctadrress
                                                          .value =
                                                      "ជ្រើសរើសឃុំ";
                                                  selectvillageidofcurrenctadrress
                                                          .value =
                                                      null;
                                                  selectedVillageNameofcurrenctadrress
                                                          .value =
                                                      "ជ្រើសរើសភូមិ";
                                                  commmuncecontroller.communce
                                                      .clear();
                                                  commmuncecontroller
                                                      .fetchcommunce(id);
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
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedCommunceNameofcurrenctadrress
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសឃុំ"
                                          : selectedCommunceNameofcurrenctadrress
                                                .value,
                                      onPressed:
                                          selectdistrictidofcurrenctadrress
                                                  .value ==
                                              null
                                          ? null
                                          : () {
                                              showCommunceSelectorSheet(
                                                context: context,
                                                communce: commmuncecontroller
                                                    .communce,
                                                selectedCommunce: selectcommunceidofcurrenctadrress.value,
                                                onSelected: (id) {
                                                  selectcommunceidofcurrenctadrress
                                                          .value =
                                                      id;
                                                  selectedCommunceNameofcurrenctadrress
                                                          .value =
                                                      commmuncecontroller
                                                          .communce
                                                          .firstWhere(
                                                            (p) => p.id == id,
                                                          )
                                                          .name!;
                                                  selectvillageidofcurrenctadrress
                                                          .value =
                                                      null;
                                                  selectedVillageNameofbirth
                                                          .value =
                                                      "ជ្រើសរើសភូមិ";
                                                  villagecontroller.village
                                                      .clear();
                                                  villagecontroller.fetvillage(
                                                    id,
                                                  );
                                                },
                                              );
                                            },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Obx(
                                    () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                      text:
                                          selectedVillageNameofcurrenctadrress
                                              .value
                                              .isEmpty
                                          ? "ជ្រើសរើសភូមិ"
                                          : selectedVillageNameofcurrenctadrress
                                                .value,
                                      onPressed:
                                          selectcommunceidofcurrenctadrress
                                                  .value ==
                                              null
                                          ? null
                                          : () {
                                              showVillageSelectorsheet(
                                                context: context,
                                                village:
                                                    villagecontroller.village,
                                                selectedVillageId: selectvillageidofcurrenctadrress.value,
                                                onSelected: (id) {
                                                  selectvillageidofcurrenctadrress
                                                          .value =
                                                      id;
                                                  selectedVillageNameofcurrenctadrress
                                                      .value = villagecontroller
                                                      .village
                                                      .firstWhere(
                                                        (p) => p.id == id,
                                                      )
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        title: "កែប្រែ",
        onTap: updateEmployee,
      ),
    );
  }
}
