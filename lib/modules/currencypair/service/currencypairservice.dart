import 'package:flutter_application_10/data/models/currencypairmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Currencypairservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getcurrencypair() async {
    try {
      final response = await apiProvider.get('viewcurrencypair');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = CurrencyPairModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("faild ${e.toString()}");
    }
  }
}
