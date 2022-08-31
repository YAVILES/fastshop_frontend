// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromMap(jsonString);

import 'dart:convert';
import 'dart:typed_data';

class CategoryModel {
  CategoryModel(
      {this.id,
      this.internalCode,
      this.description,
      this.status,
      this.statusDisplay,
      this.image,
      this.imageDisplay});

  String? id;
  String? internalCode;
  String? description;
  int? status;
  String? statusDisplay;
  Uint8List? image;
  String? imageDisplay;

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        internalCode: json["internal_code"],
        description: json["description"],
        status: json["status"],
        statusDisplay: json["status_display"],
        image: json["image"],
        imageDisplay: json["image_display"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "internal_code": internalCode,
        "description": description,
        "status": status,
        "status_display": statusDisplay,
        "image": image,
        "image_display": imageDisplay,
      };
}
