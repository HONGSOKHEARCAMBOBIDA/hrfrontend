class LeaveModel {
  List<Data>? data;

  LeaveModel({this.data});

  LeaveModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeShiftId;
  int? employeeId;
  String? employeeNameEnglish;
  String? employeeNameKhmer;
  int? gender;
  String? dob;
  String? contact;
  String? nationalIdNumber;
  int? roleId;
  String? roleName;
  int? type;
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  int? branchId;
  String? branchName;
  int? isPermission;
  int? isWithoutPermission;
  int? isWeekend;
  String? startDate;
  String? endDate;
  int? leaveDays;
  String? description;
  int? status;
  int? approveById;
  String? approveByName;

  Data(
      {this.id,
      this.employeeShiftId,
      this.employeeId,
      this.employeeNameEnglish,
      this.employeeNameKhmer,
      this.gender,
      this.dob,
      this.contact,
      this.nationalIdNumber,
      this.roleId,
      this.roleName,
      this.type,
      this.shiftId,
      this.shiftName,
      this.startTime,
      this.endTime,
      this.branchId,
      this.branchName,
      this.isPermission,
      this.isWithoutPermission,
      this.isWeekend,
      this.startDate,
      this.endDate,
      this.leaveDays,
      this.description,
      this.status,
      this.approveById,
      this.approveByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeShiftId = json['employee_shift_id'];
    employeeId = json['employee_id'];
    employeeNameEnglish = json['employee_name_english'];
    employeeNameKhmer = json['employee_name_khmer'];
    gender = json['gender'];
    dob = json['dob'];
    contact = json['contact'];
    nationalIdNumber = json['national_id_number'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    type = json['type'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    isPermission = json['is_permission'];
    isWithoutPermission = json['is_without_permission'];
    isWeekend = json['is_weekend'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    leaveDays = json['leave_days'];
    description = json['description'];
    status = json['status'];
    approveById = json['approve_by_id'];
    approveByName = json['approve_by_name'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_shift_id'] = this.employeeShiftId;
    data['employee_id'] = this.employeeId;
    data['employee_name_english'] = this.employeeNameEnglish;
    data['employee_name_khmer'] = this.employeeNameKhmer;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['contact'] = this.contact;
    data['national_id_number'] = this.nationalIdNumber;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['type'] = this.type;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['is_permission'] = this.isPermission;
    data['is_without_permission'] = this.isWithoutPermission;
    data['is_weekend'] = this.isWeekend;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['leave_days'] = this.leaveDays;
    data['description'] = this.description;
    data['status'] = this.status;
    data['approve_by_id'] = this.approveById;
    data['approve_by_name'] = this.approveByName;
    return data;
  }
}
