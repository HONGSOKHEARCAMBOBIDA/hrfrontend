class CurrencyPairModel {
  List<Data>? data;

  CurrencyPairModel({this.data});

  CurrencyPairModel.fromJson(Map<String, dynamic> json) {
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
  int? baseCurrencyId;
  String? baseCurrencyCode;
  String? baseCurrencySymbol;
  String? baseCurrencyName;
  bool? baseCurrencyIsActive;
  int? targetCurrencyId;
  String? targetCurrencyCode;
  String? targetCurrencySymbol;
  String? targetCurrencyName;
  bool? targetCurrencyIsActive;
  bool? isActive;

  Data(
      {this.id,
      this.baseCurrencyId,
      this.baseCurrencyCode,
      this.baseCurrencySymbol,
      this.baseCurrencyName,
      this.baseCurrencyIsActive,
      this.targetCurrencyId,
      this.targetCurrencyCode,
      this.targetCurrencySymbol,
      this.targetCurrencyName,
      this.targetCurrencyIsActive,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseCurrencyId = json['base_currency_id'];
    baseCurrencyCode = json['base_currency_code'];
    baseCurrencySymbol = json['base_currency_symbol'];
    baseCurrencyName = json['base_currency_name'];
    baseCurrencyIsActive = json['base_currency_is_active'];
    targetCurrencyId = json['target_currency_id'];
    targetCurrencyCode = json['target_currency_code'];
    targetCurrencySymbol = json['target_currency_symbol'];
    targetCurrencyName = json['target_currency_name'];
    targetCurrencyIsActive = json['target_currency_is_active'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['base_currency_id'] = this.baseCurrencyId;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_currency_symbol'] = this.baseCurrencySymbol;
    data['base_currency_name'] = this.baseCurrencyName;
    data['base_currency_is_active'] = this.baseCurrencyIsActive;
    data['target_currency_id'] = this.targetCurrencyId;
    data['target_currency_code'] = this.targetCurrencyCode;
    data['target_currency_symbol'] = this.targetCurrencySymbol;
    data['target_currency_name'] = this.targetCurrencyName;
    data['target_currency_is_active'] = this.targetCurrencyIsActive;
    data['is_active'] = this.isActive;
    return data;
  }
}
