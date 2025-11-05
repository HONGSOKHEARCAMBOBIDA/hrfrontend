class EmployeeShiftModel {
  List<Data>? data;

  EmployeeShiftModel({this.data});

  EmployeeShiftModel.fromJson(Map<String, dynamic> json) {
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
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;

  Data({this.id, this.shiftId, this.shiftName, this.startTime, this.endTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
