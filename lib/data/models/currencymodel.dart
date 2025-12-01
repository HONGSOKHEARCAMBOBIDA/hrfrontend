class CurrencyModel {
  List<Data>? data;

  CurrencyModel({this.data});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? symbol;
  String? name;
  bool? isActive;

  Data({this.id, this.code, this.symbol, this.name, this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    symbol = json['symbol'];
    name = json['name'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    return data;
  }
}
