// ignore_for_file: unnecessary_overrides

import 'package:fastshop/src/utils/snackbar.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:get/get.dart';

class API extends GetConnect {
  static const String baseURL = "http://127.0.0.1:8000/api";

  @override
  void onInit() {
    httpClient.baseUrl = baseURL;

    String? token = Storage.getToken();
    String? schema = Storage.getSchema();
    // It's will attach 'apikey' property on header from all requests

    Map<String, String> headers = {
      'accept': '*/*',
      'Authorization': "Bearer $token",
      'X-Dts-Schema': "$schema"
    };

    httpClient.addRequestModifier<dynamic>((request) {
      //request.headers.addAll(headers);
      return request;
    });

    // httpClient.addResponseModifier<dynamic>((request, response) {
    //   print(response.bodyString);
    // });

    httpClient.addAuthenticator<dynamic>((request) async {
      // Set the header
      //request.headers.addAll(headers);
      return request;
    });

    httpClient.addResponseModifier<dynamic>((request, response) {
      return response;
    });

    super.onInit();
  }

  @override
  GetSocket socket(String url, {Duration ping = const Duration(seconds: 5)}) {
    return super.socket(url, ping: ping);
  }

  /// for setting up GraphQl with getConnect
  @override
  Future<GraphQLResponse<T>> mutation<T>(String mutation,
      {String? url,
      Map<String, dynamic>? variables,
      Map<String, String>? headers}) {
    return super
        .mutation(mutation, url: url, variables: variables, headers: headers);
  }

  dynamic errorHandler(Response response) {
    switch (response.statusCode) {
      case 500:
        throw "Server Error pls retry later";
      case 403:
        throw 'Error occurred pls check internet and retry.';
      case 401:
        CustomSnackBar.error(message: response.body["detail"]);
        break;
      case 404:
        CustomSnackBar.error(
          message: 'Error occurred pls check internet and retry',
        );
        break;
      default:
        throw 'Error occurred retry';
    }
  }
}
