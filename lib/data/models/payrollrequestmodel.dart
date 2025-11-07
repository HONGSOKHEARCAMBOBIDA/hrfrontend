class PayrollRequestCreate {
  int? salaryId;
  int? payrollMonth;
  double? notdeduction;
  int? totalLate;
  int? penaltylate;
  int? totalEarlyexit;
  int? totalexitpenalty;
  int? leaveWithPermission;
  double? penaltyLeaveWithPermission;
  int? leaveWithoutPermission;
  double? penaltyLeaveWithoutPermission;
  int? leaveWeekend;
  double? penaltyLeaveWeekend;
  int? loanId;
  double? loanDeduction;
  int? isAttendanceBonus;
  String? bonusType;
  double? bonusAmount;
  double? totalDeductions;
  double? netsalary;
  int? status;
  int? branchId;

  PayrollRequestCreate({
    this.salaryId,
    this.payrollMonth,
    this.notdeduction,
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
    this.loanDeduction,
    this.isAttendanceBonus,
    this.bonusType,
    this.bonusAmount,
    this.totalDeductions,
    this.netsalary,
    this.status,
    this.branchId,
  });

  factory PayrollRequestCreate.fromJson(Map<String, dynamic> json) {
    return PayrollRequestCreate(
      salaryId: json['salary_id'],
      payrollMonth: json['payrollmonth'],
      notdeduction: (json['notdeduction'] as num?)?.toDouble(),
      totalLate: json['total_late'],
      penaltylate: json['penaltylate'],
      totalEarlyexit: json['total_earlyexit'],
      totalexitpenalty: json['totalexitpenalty'],
      leaveWithPermission: json['leave_with_permission'],
      penaltyLeaveWithPermission:
          (json['penalty_leave_with_permission'] as num?)?.toDouble(),
      leaveWithoutPermission: json['leave_without_permission'],
      penaltyLeaveWithoutPermission:
          (json['penalty_leave_without_permission'] as num?)?.toDouble(),
      leaveWeekend: json['leave_weekend'],
      penaltyLeaveWeekend:
          (json['penalty_leave_weekend'] as num?)?.toDouble(),
      loanId: json['loan_id'],
      loanDeduction: (json['loanDeduction'] as num?)?.toDouble(),
      isAttendanceBonus: json['is_attendance_bonus'],
      bonusType: json['bonus_type'],
      bonusAmount: (json['bonus_amount'] as num?)?.toDouble(),
      totalDeductions: (json['totalDeductions'] as num?)?.toDouble(),
      netsalary: (json['netsalary'] as num?)?.toDouble(),
      status: json['status'],
      branchId: json['branch_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['salary_id'] = salaryId;
    data['payrollmonth'] = payrollMonth;
    data['notdeduction'] = notdeduction;
    data['total_late'] = totalLate;
    data['penaltylate'] = penaltylate;
    data['total_earlyexit'] = totalEarlyexit;
    data['totalexitpenalty'] = totalexitpenalty;
    data['leave_with_permission'] = leaveWithPermission;
    data['penalty_leave_with_permission'] = penaltyLeaveWithPermission;
    data['leave_without_permission'] = leaveWithoutPermission;
    data['penalty_leave_without_permission'] = penaltyLeaveWithoutPermission;
    data['leave_weekend'] = leaveWeekend;
    data['penalty_leave_weekend'] = penaltyLeaveWeekend;
    data['loan_id'] = loanId;
    data['loanDeduction'] = loanDeduction;
    data['is_attendance_bonus'] = isAttendanceBonus;
    data['bonus_type'] = bonusType;
    data['bonus_amount'] = bonusAmount;
    data['totalDeductions'] = totalDeductions;
    data['netsalary'] = netsalary;
    data['status'] = status;
    data['branch_id'] = branchId;
    return data;
  }
}
