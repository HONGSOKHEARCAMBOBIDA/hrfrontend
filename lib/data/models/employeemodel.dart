class EmployeeModel {
  List<Data>? data;

  EmployeeModel({this.data});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? branchId;
  String? branchName;
  String? nameEn;
  String? name;
  int? gender;
  String? dob;
  String? contact;
  String? nationalIdNumber;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  int? communeId;
  String? communeName;
  int? villageId;
  String? villageName;
  int? roleId;
  String? roleName;
  String? hireDate;
  int? type;
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  int? employeeShitfId;
  int? salaryId;
  String? baseSalary;
  int? workedDay;
  String? dailyRate;
  bool? isActive;
  int? assignBranchId;

  Data(
      {this.id,
      this.branchId,
      this.branchName,
      this.nameEn,
      this.name,
      this.gender,
      this.dob,
      this.contact,
      this.nationalIdNumber,
      this.provinceId,
      this.provinceName,
      this.districtId,
      this.districtName,
      this.communeId,
      this.communeName,
      this.villageId,
      this.villageName,
      this.roleId,
      this.roleName,
      this.hireDate,
      this.type,
      this.shiftId,
      this.shiftName,
      this.startTime,
      this.endTime,
      this.employeeShitfId,
      this.salaryId,
      this.baseSalary,
      this.workedDay,
      this.dailyRate,
      this.isActive,
      this.assignBranchId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    nameEn = json['name_en'];
    name = json['name_kh'];
    gender = json['gender'];
    dob = json['dob'];
    contact = json['contact'];
    nationalIdNumber = json['national_id_number'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    communeId = json['commune_id'];
    communeName = json['commune_name'];
    villageId = json['village_id'];
    villageName = json['village_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    hireDate = json['hire_date'];
    type = json['type'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    employeeShitfId = json['employee_shitf_id'];
    salaryId = json['salary_id'];
    baseSalary = json['base_salary'];
    workedDay = json['worked_day'];
    dailyRate = json['daily_rate'];
    isActive = json['is_active'];
    assignBranchId = json['assign_branch_id'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.name;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['contact'] = this.contact;
    data['national_id_number'] = this.nationalIdNumber;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['commune_id'] = this.communeId;
    data['commune_name'] = this.communeName;
    data['village_id'] = this.villageId;
    data['village_name'] = this.villageName;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['hire_date'] = this.hireDate;
    data['type'] = this.type;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['employee_shitf_id'] = this.employeeShitfId;
    data['salary_id'] = this.salaryId;
    data['base_salary'] = this.baseSalary;
    data['worked_day'] = this.workedDay;
    data['daily_rate'] = this.dailyRate;
    data['is_active'] = this.isActive;
    data['assign_branch_id'] = this.assignBranchId;
    return data;
  }
}
