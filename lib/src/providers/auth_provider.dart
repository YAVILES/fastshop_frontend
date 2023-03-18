import 'package:dio/dio.dart';
import 'package:fastshop/src/models/auth_model.dart';
import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/utils/api.dart';

class AuthProvider {
  Future<AuthModel?> login(Map<String, String> data) async {
    try {
      Response resp = await API.post('/users/login', data);
      if (resp.statusCode == 200) {
        return AuthModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> currentUser() async {
    try {
      Response resp = await API.get('/security/user/current/');
      if (resp.statusCode == 200) {
        return UserModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<Map<String, dynamic>?> userVerify(Map<String, String> data) async {
    try {
      Response resp = await API.post('/security/verify/validate_user/', data);
      if (resp.statusCode == 200) {
        return resp.data;
      }
    } on ErrorAPI {
      rethrow;
    }
    // ignore: avoid_returning_null_for_void
    return null;
  }

  Future<Map<String, dynamic>?> sendEmail(Map<String, String> data) async {
    try {
      Response resp = await API.post('/security/verify/send_emails/', data);
      if (resp.statusCode == 200) {
        return resp.data;
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<Map<String, dynamic>?> validateCode(Map<String, String> data) async {
    try {
      Response resp = await API.post('/security/verify/validate_code/', data);
      if (resp.statusCode == 200) {
        return resp.data;
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<Map<String, dynamic>?> changePassword(Map<String, String> data) async {
    try {
      Response resp = await API.post('/security/verify/change_password/', data);
      if (resp.statusCode == 200) {
        return resp.data;
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }
}
