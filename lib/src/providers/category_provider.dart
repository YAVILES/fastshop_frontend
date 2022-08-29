import 'package:fastshop/src/models/category_model.dart';
import 'package:fastshop/src/models/response_list.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:get/get.dart';

class CategoryProvider {
  API api = GetInstance().find<API>();
  Future<ResponseData?> getCategoriesPaginated(
      String? url, Map<String, dynamic>? params) async {
    Response resp = await api.get<Map<String, dynamic>>(
        url ?? '/inventory/category/',
        query: params);
    if (resp.isOk) {
      return ResponseData.fromMap(resp.body);
    } else {
      api.errorHandler(resp);
    }
    return null;
  }

  Future<CategoryModel?> saveCategory(CategoryModel category) async {
    Response resp = await api.post<Map<String, dynamic>>(
      '/inventory/category/',
      category.toMap(),
    );
    if (resp.isOk) {
      return CategoryModel.fromMap(resp.body);
    } else {
      api.errorHandler(resp);
    }
    return null;
  }
}
