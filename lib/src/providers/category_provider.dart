import 'package:dio/dio.dart';
import 'package:fastshop/src/models/category_model.dart';
import 'package:fastshop/src/models/response_list.dart';
import 'package:fastshop/src/utils/api.dart';

class CategoryProvider {
  static const baseUrl = '/inventory/category/';
  Future<ResponseData?> getCategoriesPaginated(
      String? url, Map<String, dynamic>? params) async {
    try {
      Response resp =
          await API.get(url ?? '/inventory/category/', params: params);
      if (resp.statusCode == 200) {
        return ResponseData.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<CategoryModel?> getCategory(String id) async {
    try {
      Response resp = await API.get('$baseUrl$id');
      if (resp.statusCode == 200) {
        return CategoryModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<CategoryModel?> exportData(Map<String, dynamic> params) async {
    try {
      Response resp = await API.get('${baseUrl}export/', params: params);
      if (resp.statusCode == 200) {
        return CategoryModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<CategoryModel?> saveCategory(CategoryModel category) async {
    try {
      final mapData = {
        if (category.image?.bytes != null)
          'image': MultipartFile.fromBytes(
            category.image!.bytes!,
            filename: category.image!.name,
          ),
        ...category.toMap(),
      };

      final formData = FormData.fromMap(mapData);
      Response resp;
      if (category.id == null) {
        resp = await API.post('/inventory/category/', formData);
      } else {
        resp = await API.put('/inventory/category/${category.id}/', formData);
      }
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return CategoryModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }
}
