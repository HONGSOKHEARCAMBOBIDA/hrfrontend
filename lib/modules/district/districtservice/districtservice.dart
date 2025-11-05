import 'package:flutter_application_10/data/models/districtmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Districtservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getdistrict(int provinceid) async {
    try {
      final response = await apiProvider.get('viewdistrict/${provinceid}');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = DistrictModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception('Faild ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Faild ${e.toString()}');
    }
  }
}
