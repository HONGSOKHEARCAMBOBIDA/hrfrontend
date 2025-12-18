class LoginModel {
  String? message;
  String? token;
  User? user;

  LoginModel({this.message, this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  List<Parts>? parts;
  String? phone;
  int? roleId;

  User({this.id, this.name, this.parts, this.phone, this.roleId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(new Parts.fromJson(v));
      });
    }
    phone = json['phone'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    data['phone'] = this.phone;
    data['role_id'] = this.roleId;
    return data;
  }
}

class Parts {
  int? id;
  int? partId;
  String? partName;

  Parts({this.id, this.partId, this.partName});

  Parts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partId = json['part_id'];
    partName = json['part_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['part_id'] = this.partId;
    data['part_name'] = this.partName;
    return data;
  }
}
