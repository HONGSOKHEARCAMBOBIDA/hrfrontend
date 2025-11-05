import 'package:flutter_application_10/data/models/villagemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Villageservice {
  final ApiProvider apiProvider = ApiProvider();
  // create final instance of ApiProvider

  Future<List<Data>> getvillage(int communceid) async {
    try {
      final response = await apiProvider.get('viewvillage/$communceid');
      if (response.statusCode == 200) {
          final json = response.data;
          final model = VillageModel.fromJson(json);
          return model.data ?? [];        
      } else {
        throw Exception(
          'Faild to load village: status code ${response.statusCode},Message: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
