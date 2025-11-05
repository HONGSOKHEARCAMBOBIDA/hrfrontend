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
  String? name;
  String? username;
  String? email;
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
  bool? isActive;

  Data(
      {this.id,
      this.branchId,
      this.branchName,
      this.nameEn,
      this.name,
      this.username,
      this.email,
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
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    nameEn = json['name_en'];
    name = json['name_kh'];
    username = json['username'];
    email = json['email'];
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
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
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
    data['is_active'] = this.isActive;
    return data;
  }
}
