// To parse this JSON data, do
//
//     final auth = authFromMap(jsonString);

import 'dart:convert';

class AuthModel {
  String accessToken;
  String refreshToken;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
        accessToken: map['accessToken'] ?? '',
        refreshToken: map['refreshToken'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));
}
