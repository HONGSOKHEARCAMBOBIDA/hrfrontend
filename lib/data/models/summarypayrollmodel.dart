class SummaryPayRollModel {
  List<Data>? data;

  SummaryPayRollModel({this.data});

  SummaryPayRollModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    if (data != null) {
      jsonData['data'] = data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class Data {
  int? salaryId;
  int? employeeShiftId;
  double? baseSalary;
  int? workedDay;
  double? dailyRate;
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  int? branchId;
  String? branchName;
  int? employeeId;
  String? nameEn;
  String? nameKh;
  int? gender;
  String? genderText;
  String? dob;
  String? contact;
  int? roleId;
  String? roleName;
  int? type;
  String? typeText;
  String? hireDate;
  int? totalLate;
  double? penaltylate;
  int? totalEarlyexit;
  double? totalexitpenalty;
  int? leaveWithPermission;
  double? penaltyLeaveWithPermission;
  int? leaveWithoutPermission;
  double? penaltyLeaveWithoutPermission;
  int? leaveWeekend;
  double? penaltyLeaveWeekend;
  int? loanId;
  double? loanAmount;
  double? remainingBalance;
  int? attendancecount;
  double? notdeduction;
  double? totalDeductions;
  double? netsalary;
  int? isBonusAttendanace;

  Data({
    this.salaryId,
    this.employeeShiftId,
    this.baseSalary,
    this.workedDay,
    this.dailyRate,
    this.shiftId,
    this.shiftName,
    this.startTime,
    this.endTime,
    this.branchId,
    this.branchName,
    this.employeeId,
    this.nameEn,
    this.nameKh,
    this.gender,
    this.genderText,
    this.dob,
    this.contact,
    this.roleId,
    this.roleName,
    this.type,
    this.typeText,
    this.hireDate,
    this.totalLate,
    this.penaltylate,
    this.totalEarlyexit,
    this.totalexitpenalty,
    this.leaveWithPermission,
    this.penaltyLeaveWithPermission,
    this.leaveWithoutPermission,
    this.penaltyLeaveWithoutPermission,
    this.leaveWeekend,
    this.penaltyLeaveWeekend,
    this.loanId,
    this.loanAmount,
    this.remainingBalance,
    this.attendancecount,
    this.notdeduction,
    this.totalDeductions,
    this.netsalary,
    this.isBonusAttendanace,
  });


  Data.fromJson(Map<String, dynamic> json) {
    salaryId = json['salary_id'];
    employeeShiftId = json['employee_shift_id'];
    baseSalary = (json['base_salary'] as num?)?.toDouble();
    workedDay = json['worked_day'];
    dailyRate = (json['daily_rate'] as num?)?.toDouble();
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    employeeId = json['employee_id'];
    nameEn = json['name_en'];
    nameKh = json['name_kh'];
    gender = json['gender'];
    genderText = json['gender_text'];
    dob = json['dob'];
    contact = json['contact'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    type = json['type'];
    typeText = json['type_text'];
    hireDate = json['hire_date'];
    totalLate = json['total_late'];
    penaltylate = (json['penaltylate'] as num?)?.toDouble();
    totalEarlyexit = json['total_earlyexit'];
    totalexitpenalty = (json['totalexitpenalty'] as num?)?.toDouble();
    leaveWithPermission = json['leave_with_permission'];
    penaltyLeaveWithPermission =
        (json['penalty_leave_with_permission'] as num?)?.toDouble();
    leaveWithoutPermission = json['leave_without_permission'];
    penaltyLeaveWithoutPermission =
        (json['penalty_leave_without_permission'] as num?)?.toDouble();
    leaveWeekend = json['leave_weekend'];
    penaltyLeaveWeekend =
        (json['penalty_leave_weekend'] as num?)?.toDouble();
    loanId = json['loan_id'];
    loanAmount = (json['loan_amount'] as num?)?.toDouble();
    remainingBalance = (json['remaining_balance'] as num?)?.toDouble();
    attendancecount = json['attendancecount'];
    notdeduction = (json['notdeduction'] as num?)?.toDouble();
    totalDeductions = (json['totalDeductions'] as num?)?.toDouble();
    netsalary = (json['netsalary'] as num?)?.toDouble();
    isBonusAttendanace = json['is_bonus_attendanace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['salary_id'] = salaryId;
    data['employee_shift_id'] = employeeShiftId;
    data['base_salary'] = baseSalary;
    data['worked_day'] = workedDay;
    data['daily_rate'] = dailyRate;
    data['shift_id'] = shiftId;
    data['shift_name'] = shiftName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    data['employee_id'] = employeeId;
    data['name_en'] = nameEn;
    data['name_kh'] = nameKh;
    data['gender'] = gender;
    data['gender_text'] = genderText;
    data['dob'] = dob;
    data['contact'] = contact;
    data['role_id'] = roleId;
    data['role_name'] = roleName;
    data['type'] = type;
    data['type_text'] = typeText;
    data['hire_date'] = hireDate;
    data['total_late'] = totalLate;
    data['penaltylate'] = penaltylate;
    data['total_earlyexit'] = totalEarlyexit;
    data['totalexitpenalty'] = totalexitpenalty;
    data['leave_with_permission'] = leaveWithPermission;
    data['penalty_leave_with_permission'] = penaltyLeaveWithPermission;
    data['leave_without_permission'] = leaveWithoutPermission;
    data['penalty_leave_without_permission'] =
        penaltyLeaveWithoutPermission;
    data['leave_weekend'] = leaveWeekend;
    data['penalty_leave_weekend'] = penaltyLeaveWeekend;
    data['loan_id'] = loanId;
    data['loan_amount'] = loanAmount;
    data['remaining_balance'] = remainingBalance;
    data['attendancecount'] = attendancecount;
    data['notdeduction'] = notdeduction;
    data['totalDeductions'] = totalDeductions;
    data['netsalary'] = netsalary;
    data['is_bonus_attendanace'] = isBonusAttendanace;
    return data;
  }
}
