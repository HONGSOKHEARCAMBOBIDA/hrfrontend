import 'package:flutter_application_10/data/models/partmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Partservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getpart() async {
    try {
      final response = await apiProvider.get('viewpart');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = PartModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Faild ${e.toString()}");
    }
  }
}
