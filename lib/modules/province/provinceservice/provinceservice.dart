import 'package:flutter_application_10/data/models/provincemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Provinceservice {
  final ApiProvider apiProvider = ApiProvider();

  Future<List<Data>> getProvince() async {
    try {
      final response = await apiProvider.get('viewprovince');

      if (response.statusCode == 200) {
        // ✅ API returns an object with "data": [...]
        final json = response.data;
        final model = ProvinceModel.fromJson(json);

        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
