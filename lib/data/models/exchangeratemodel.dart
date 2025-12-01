class ExchangeRateModel {
  List<Data>? data;

  ExchangeRateModel({this.data});

  ExchangeRateModel.fromJson(Map<String, dynamic> json) {
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
  int? pairId;
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
  String? rate;
  int? isActive;
  int? isEdit;
  int? createBy;
  String? createByName;
  int? updateBy;
  String? updateByName;

  Data(
      {this.id,
      this.pairId,
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
      this.rate,
      this.isActive,
      this.isEdit,
      this.createBy,
      this.createByName,
      this.updateBy,
      this.updateByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pairId = json['pair_id'];
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
    rate = json['rate'];
    isActive = json['is_active'];
    isEdit = json['is_edit'];
    createBy = json['create_by'];
    createByName = json['create_by_name'];
    updateBy = json['update_by'];
    updateByName = json['update_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pair_id'] = this.pairId;
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
    data['rate'] = this.rate;
    data['is_active'] = this.isActive;
    data['is_edit'] = this.isEdit;
    data['create_by'] = this.createBy;
    data['create_by_name'] = this.createByName;
    data['update_by'] = this.updateBy;
    data['update_by_name'] = this.updateByName;
    return data;
  }
}
