// To parse this JSON data, do
//
//     final BrandModel = BrandModelFromMap(jsonString);

import 'dart:convert';

import 'package:file_picker/file_picker.dart';

class BrandModel {
  BrandModel(
      {this.id,
      this.internalCode,
      this.description,
      this.is_active,
      this.image,
      this.imageDisplay});

  String? id;
  String? internalCode;
  String? description;
  bool? is_active;
  PlatformFile? image;
  String? imageDisplay;

  factory BrandModel.fromJson(String str) =>
      BrandModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandModel.fromMap(Map<String, dynamic> json) => BrandModel(
        id: json["id"],
        internalCode: json["internal_code"],
        description: json["description"],
        is_active: json["is_active"],
        imageDisplay: json["image_display"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "internal_code": internalCode,
        "description": description,
        "is_active": is_active,
        "image_display": imageDisplay,
      };
}
