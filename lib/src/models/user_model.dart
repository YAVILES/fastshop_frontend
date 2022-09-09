// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString?);

import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.code,
    this.username,
    this.email,
    this.password,
    this.name,
    this.lastName,
    this.fullName,
    this.direction,
    this.telephone,
    this.phone,
    this.point,
    this.isSuperuser,
    this.status,
    this.statusDisplay,
    this.created,
    this.permissions,
  });

  String? id;
  String? code;
  String? username;
  String? email;
  String? password;
  String? name;
  String? lastName;
  String? fullName;
  String? direction;
  String? telephone;
  String? phone;
  String? point;
  bool? isSuperuser;
  int? status;
  String? statusDisplay;
  DateTime? created;
  dynamic permissions;

  factory UserModel.fromMap(Map<String?, dynamic> json) => UserModel(
        id: json["id"],
        code: json["code"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        direction: json["direction"],
        telephone: json["telephone"],
        phone: json["phone"],
        point: json["point"],
        isSuperuser: json["is_superuser"],
        status: json["status"],
        statusDisplay: json["status_display"],
        permissions: json["full_permissions"],
        created: DateTime.parse(json["created"]),
      );

  Map<String?, dynamic> toMap() => {
        "id": id,
        "code": code,
        "username": username,
        "email": email,
        "password": password,
        "name": name,
        "last_name": lastName,
        "full_name": fullName,
        "direction": direction,
        "telephone": telephone,
        "phone": phone,
        "point": point,
        "is_superuser": isSuperuser,
        "status": status,
        "status_display": statusDisplay,
        "full_permissions": permissions,
        "created": created?.toIso8601String()
      };

  UserModel fromJson(String? str) => UserModel.fromMap(json.decode(str!));

  String? toJson(UserModel data) => json.encode(data.toMap());
}
