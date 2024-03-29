import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:flutter/foundation.dart';

class API {
  // Development
  static const String baseURL = "http://194.163.161.64:8000/api/v1";

  // Production
  // static const String baseURL = "https://194.163.161.64:8000/api/v1";
  static final Dio _dio = Dio();

  static void configureDio(context) {
    _dio.options.baseUrl = baseURL;
    _dio.options.headers = {
      'client': '${Storage.getSchema()}',
      'Authorization': 'Bearer ${Storage.getToken()}',
      'accept': '*/*',
    };
    if (context != null) {
      initializedInterceptors(context);
    }
  }

  static initializedInterceptors(context) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, ErrorInterceptorHandler errorHandler) async {
          if (kDebugMode) {
            print(
                'onErrorMessage: ${error.response} ${error.response?.statusCode} ${error.requestOptions.path}');
          }
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            if (error.requestOptions.path == '/token/refresh/') {
              return errorHandler.next(error);
            } else if (error.requestOptions.path != '/token/' ||
                error.requestOptions.path != '/security/user/current/') {
              try {
                Response response = await refreshToken();
                if (response.statusCode == 200) {
                  //get new tokens ...
                  final data = response.data;
                  await Storage.setToken(data['access'], data['refresh']);
                  API.configureDio(context);
                  //create request with new access token
                  final opts = Options(method: error.requestOptions.method);
                  final cloneReq = await _dio.request(error.requestOptions.path,
                      options: opts,
                      data: error.requestOptions.data,
                      queryParameters: error.requestOptions.queryParameters);

                  return errorHandler.resolve(cloneReq);
                }
              } on ErrorAPI {
                return errorHandler.next(error);
              }
            } else {
              return errorHandler.next(error);
            }
          }
          return errorHandler.next(error);
        },
        onRequest: (RequestOptions request, requestHandler) {
          if (kDebugMode) {
            print("onRequest: ${request.method} ${request.uri}");
          }
          return requestHandler.next(request);
        },
        onResponse: (response, responseHandler) {
          if (kDebugMode) {
            print('onResponse: ${response.statusCode}');
          }
          return responseHandler.next(response);
        },
      ),
    );
  }

  static Future<Response> refreshToken() async {
    Response response;
    final refreshToken = Storage.getRefreshToken();
    try {
      response =
          await _dio.post('/token/refresh/', data: {'refresh': refreshToken});
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }
    return response;
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Response response;
    try {
      response =
          await _dio.get(path, queryParameters: params, options: options);
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }
    return response;
  }

  static Future<Response> post(String path, data) async {
    Response response;
    try {
      response = await _dio.post(path, data: data);
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }

    return response;
  }

  static Future<Response> put(String path, data) async {
    Response response;
    try {
      response = await _dio.put(path, data: data);
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }
    return response;
  }

  static Future<Response> patch(String path, data) async {
    Response response;
    try {
      response = await _dio.patch(path, data: data);
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }
    return response;
  }

  static Future<Response> delete(String path, {List<String>? ids}) async {
    Response response;
    try {
      if (ids == null) {
        response = await _dio.delete(path);
      } else {
        response = await _dio.delete(path, data: {'ids': ids});
      }
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }
    return response;
  }

  static Future<Response> uploadFile(String path, Uint8List bytes) async {
    final formData = FormData.fromMap({
      'photo': MultipartFile.fromBytes(bytes),
    });
    Response response;
    try {
      response = await _dio.patch(path, data: formData);
    } on DioError catch (e) {
      throw ErrorAPI.fromJson(e.response.toString());
    }
    return response;
  }
}

class ErrorAPI {
  dynamic detail;
  List<String>? error;

  ErrorAPI({
    this.detail,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'detail': detail,
      'error': error,
    };
  }

  factory ErrorAPI.fromMap(Map<String, dynamic> map) {
    return ErrorAPI(
      detail: map['detail'],
      error: map['error'] != null ? List<String>.from(map['error']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorAPI.fromJson(String source) =>
      ErrorAPI.fromMap(json.decode(source));
}
