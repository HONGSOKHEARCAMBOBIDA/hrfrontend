import 'package:flutter_application_10/data/models/communcemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Communceservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getcommunce(int districtid) async {
    try {
      final response = await apiProvider.get('viewcommunce/$districtid');
      if (response.statusCode == 200) {
          final json = response.data;
          final model = CommunceModel.fromJson(json);
          return model.data ?? [];
      } else {
        throw Exception(
          'Faild to get communce Message ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Fiald ${e.toString()}');
    }
  }
}
