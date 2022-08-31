import 'package:dio/dio.dart';
import 'package:fastshop/src/models/category_model.dart';
import 'package:fastshop/src/models/response_list.dart';
import 'package:fastshop/src/utils/api.dart';

class CategoryProvider {
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

  Future<CategoryModel?> saveCategory(CategoryModel category) async {
    try {
      Response resp = await API.post(
        '/inventory/category/',
        category.toMap(),
      );
      if (resp.statusCode == 200) {
        return CategoryModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }
}
