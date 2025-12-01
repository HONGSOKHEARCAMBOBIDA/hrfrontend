import 'package:flutter_application_10/data/models/exchangeratemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class Exchangrateservice {
  final ApiProvider apiProvider = ApiProvider();

  Future<List<Data>> getexchangreate() async {
    try {
      final response = await apiProvider.get('viewexchangerate');
      if (response.statusCode == 200) {
        final json = response.data;
        final model = ExchangeRateModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> createexchangerate({
    required int pairID,
    required double rate,
  }) async {
    try {
      final body = {'pair_id': pairID, 'rate': rate};
      final response = await apiProvider.post('addexchangerate', body);

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "បង្កេីតមិនបានទេ");
        return false;
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> updateexchangerate({
    required int exchangerateID,
    required int pairID,
    required double rate,
  }) async {
    try {
      final body = {'pair_id': pairID, 'rate': rate};
      final response =
          await apiProvider.put('updatexchangerate/$exchangerateID', body);

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> changestatusexchangerate({
    required int exchangerateID,
  }) async {
    try {
      // if backend expects JSON body, example:
      final body = {"id": exchangerateID};

      final response = await apiProvider.put(
        'changestatusexchangerate/$exchangerateID',
        body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
          title: "កំហុស", message: "មានបញ្ហាក្នុងការកែប្រែប្រភេទអត្រាប្តូរប្រាក់");
      return false; // avoid null return
    }
  }
}
