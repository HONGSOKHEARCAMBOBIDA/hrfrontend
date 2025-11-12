class UserModel {
  List<Data>? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? nameKh;
  String? username;
  String? email;
  int? gender;
  String? contact;
  String? nationalIdNumber;
  int? roleId;
  String? roleName;
  bool? isActive;

  Data(
      {this.id,
      this.branchId,
      this.branchName,
      this.nameEn,
      this.nameKh,
      this.username,
      this.email,
      this.gender,
      this.contact,
      this.nationalIdNumber,
      this.roleId,
      this.roleName,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    nameEn = json['name_en'];
    nameKh = json['name_kh'];
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    contact = json['contact'];
    nationalIdNumber = json['national_id_number'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.nameKh;
    data['username'] = this.username;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['contact'] = this.contact;
    data['national_id_number'] = this.nationalIdNumber;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['is_active'] = this.isActive;
    return data;
  }
}
