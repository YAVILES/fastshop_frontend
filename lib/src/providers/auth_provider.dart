import 'package:fastshop/src/models/auth_model.dart';
import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:get/get.dart';

class AuthProvider extends API {
  Future<AuthModel?> login(Map<String, String> data) async {
    Response resp = await post<Map<String, dynamic>>('/token/', data);
    if (resp.isOk) {
      return AuthModel.fromMap(resp.body);
    } else {
      errorHandler(resp);
    }
    return null;
  }

  Future<UserModel?> currentUser() async {
    Response resp = await get<Map<String, dynamic>>('/security/user/current/');
    if (resp.isOk) {
      return UserModel.fromMap(resp.body);
    } else {
      errorHandler(resp);
    }
    return null;
  }
/*
  Future refreshToken() async {
    Response resp = await get('/token/refresh/');
    if (resp.isOk) {
      return resp.body;
    } else {
      errorHandler(resp);
    }
    return null;
  }
  */
}
