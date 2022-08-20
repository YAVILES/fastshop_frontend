import 'package:dio/dio.dart';
import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/utils/api.dart';

class AuthProvider extends API {
  Future login(Map<String, String> data) async {
    try {
      return await API.post('/token/', data);
    } on ErrorAPI catch (e) {
      return e;
    }
  }

  Future<UserModel?> currentUser() async {
    try {
      Response resp = await API.get('/security/user/current/');
      if (resp.statusCode == 200) {
        return UserModel.fromJson(resp.data);
      }
    } on ErrorAPI {
      return null;
    }
    return null;
  }

  Future refreshToken() async {
    Response resp = await API.get('/token/refresh/');
    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }
}
