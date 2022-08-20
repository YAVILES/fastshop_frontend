// To parse this JSON data, do
//
//     final auth = authFromMap(jsonString);

import 'dart:convert';

class AuthModel {
  String token;
  String refresh;

  AuthModel({
    required this.token,
    required this.refresh,
  });

  Map<String, dynamic> toMap() {
    return {'token': token, 'refresh': refresh};
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(token: map['token'] ?? '', refresh: map['refresh'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));
}
