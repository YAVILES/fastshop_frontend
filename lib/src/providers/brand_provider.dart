import 'package:dio/dio.dart';
import 'package:fastshop/src/models/brand_model.dart';
import 'package:fastshop/src/models/response_list.dart';
import 'package:fastshop/src/utils/api.dart';

class BrandProvider {
  static const baseUrl = '/inventory/brand/';
  Future<ResponseData?> getBrandPaginated(
      String? url, Map<String, dynamic>? params) async {
    try {
      Response resp = await API.get(url ?? '/inventory/brand/', params: params);
      if (resp.statusCode == 200) {
        return ResponseData.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<BrandModel?> getBrand(String id) async {
    try {
      Response resp = await API.get('$baseUrl$id');
      if (resp.statusCode == 200) {
        return BrandModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<BrandModel?> exportData(Map<String, dynamic> params) async {
    try {
      Response resp = await API.get('${baseUrl}export/', params: params);
      if (resp.statusCode == 200) {
        return BrandModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }

  Future<BrandModel?> saveBrand(BrandModel brand) async {
    try {
      final mapData = {
        if (brand.image?.bytes != null)
          'image': MultipartFile.fromBytes(
            brand.image!.bytes!,
            filename: brand.image!.name,
          ),
        ...brand.toMap(),
      };

      final formData = FormData.fromMap(mapData);
      Response resp;
      if (brand.id == null) {
        resp = await API.post('/inventory/brand/', formData);
      } else {
        resp = await API.put('/inventory/brand/${brand.id}/', formData);
      }
      // Response resp = await API.post('/inventory/brand/', formData);
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return BrandModel.fromMap(resp.data);
      }
    } on ErrorAPI {
      rethrow;
    }
    return null;
  }
}
