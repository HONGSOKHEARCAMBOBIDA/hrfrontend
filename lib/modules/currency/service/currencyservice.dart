import 'package:flutter_application_10/data/models/currencymodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Currencyservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getcurrency() async {
    try {
      final response = await apiProvider.get('viewcurrency');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = CurrencyModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> createcurrency({
    required String code,
    required String symbol,
    required String name,
  }) async {
    try {
      final body = {'code': code, 'symbol': symbol, 'name': name};
      final response = await apiProvider.post('addcurrency', body);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "បង្កេីតមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> updatecurrency({
    required int currencyID,
    required String code,
    required String symbol,
    required String name,
  }) async {
    try {
      final body = {'code': code, 'symbol': symbol, 'name': name};
      final response = await apiProvider.put(
        "updatecurrency/${currencyID}",
        body,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> changestatuscurrency({required int currencyID}) async {
    try {
      final response = await apiProvider.put(
        "changestatuscurrency/${currencyID}",
        currencyID,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "កំហុស",
        message: "មានបញ្ហា: ${e.toString()}",
      );
      return false;
    }
  }
}
