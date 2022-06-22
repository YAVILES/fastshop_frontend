import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:get/get.dart';

class AuthProvider extends API {
  Future login(Map<String, String> data) async {
    Response resp = await post('/token/', data);
    if (resp.isOk) {
      return resp.body;
    } else {
      errorHandler(resp);
    }
  }

  Future<UserModel?> currentUser() async {
    Response resp = await get('/security/user/current/');
    if (resp.isOk) {
      return UserModel.fromJson(resp.body);
    } else {
      errorHandler(resp);
    }
    return null;
  }

  Future<UserModel?> refreshToken() async {
    Response resp = await get('/token/refresh/');
    if (resp.isOk) {
      return UserModel.fromJson(resp.body);
    } else {
      errorHandler(resp);
    }
    return null;
  }
}
