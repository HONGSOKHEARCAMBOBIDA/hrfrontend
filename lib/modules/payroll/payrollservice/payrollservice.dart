import 'package:flutter_application_10/data/models/summarypayrollmodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';

class Payrollservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getsummarypayroll({
    required int branchid,
    required int month,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchid != null) params['branch_id'] = branchid;
      if (month != null) params['month'] = month;
      final respone = await apiProvider.get(
        'viewpayroll',
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (respone.statusCode == 200) {
        final json = respone.data;
        final model = SummaryPayRollModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed: ${respone.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
