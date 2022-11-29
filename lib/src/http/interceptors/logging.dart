import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Logging extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      debugPrint(json.encode("URL: ${options.baseUrl + options.path}"));
      if (options.data != null) {
        // debugPrint("Dados: ${json.encode(options.data)}");
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      if (response.data != null) {
        debugPrint("Retorno da api: ${response.requestOptions.baseUrl + response.requestOptions.path}");
        // debugPrint("Dados: ${json.encode(response.data)}");
      }
    }

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // fazer um tratamento dos erros aqui depois
    return super.onError(err, handler);
  }

}