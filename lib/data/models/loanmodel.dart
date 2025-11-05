class LoanModel {
  List<Data>? data;

  LoanModel({this.data});

  LoanModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? employeeName;
  int? branchId;
  String? branchName;
  int? loanAmount;
  int? remainingBalance;
  int? status;

  Data(
      {this.id,
      this.employeeId,
      this.employeeName,
      this.branchId,
      this.branchName,
      this.loanAmount,
      this.remainingBalance,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    loanAmount = json['loan_amount'];
    remainingBalance = json['remaining_balance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['loan_amount'] = this.loanAmount;
    data['remaining_balance'] = this.remainingBalance;
    data['status'] = this.status;
    return data;
  }
}
