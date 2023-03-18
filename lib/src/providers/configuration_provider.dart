import 'package:dio/dio.dart';
import 'package:fastshop/src/models/configuration_model.dart';
import 'package:fastshop/src/utils/api.dart';

class ConfigurationProvider {
  Future<ConfigurationModel> getConfiguration(
      Map<String, dynamic>? params) async {
    try {
      Response resp =
          await API.get('/configuration?paginator=false', params: params);
      if (resp.statusCode == 200) {
        return resp.data
            ? ConfigurationModel.fromMap(resp.data[0])
            : ConfigurationModel();
      }
    } on ErrorAPI {
      rethrow;
    }
    return ConfigurationModel();
  }

  Future<bool?> saveConfiguration(Map<String, dynamic> params) async {
    try {
      Response resp = await API.post('/configuration', params);
      if (resp.statusCode == 200) {
        return true;
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }
}
