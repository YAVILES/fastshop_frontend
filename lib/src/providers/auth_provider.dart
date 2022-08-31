import 'package:fastshop/src/models/auth_model.dart';
import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:get/get.dart';

class AuthProvider {
  API api = GetInstance().find<API>();
  Future<AuthModel?> login(Map<String, String> data) async {
    API api = GetInstance().find<API>();
    Response resp = await api.post<Map<String, dynamic>>('/token/', data);
    if (resp.isOk) {
      return AuthModel.fromMap(resp.body);
    } else {
      api.errorHandler(resp);
    }
    return null;
  }

  Future<UserModel?> currentUser() async {
    Response resp =
        await api.get<Map<String, dynamic>>('/security/user/current/');
    if (resp.isOk) {
      return UserModel.fromMap(resp.body);
    } else {
      api.errorHandler(resp);
    }
    return null;
  }

  Future userVerify(Map<String, String> data) async {
    try {
      Response resp =
          await api.post<dynamic>('/security/verify/validate_user/', data);
      if (resp.isOk) {
        return resp.body;
      } else {
        api.errorHandler(resp);
      }
      print('entro a userVerify');
    } catch (e) {
      return null;
    }
    // ignore: avoid_returning_null_for_void
    return null;
  }

  Future sendEmail(Map<String, String> data) async {
    try {
      Response resp =
          await api.post<dynamic>('/security/verify/send_emails/', data);
      if (resp.isOk) {
        return resp.body;
      } else {
        api.errorHandler(resp);
      }
    } catch (e) {
      return null;
    }
  }

/*
  Future refreshToken() async {
    Response resp = await get('/token/refresh/');
    if (resp.isOk) {
      return resp.body;
    } else {
      api.errorHandler(resp);
    }
    return null;
  }
  */
}
