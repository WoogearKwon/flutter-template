import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

abstract class BaseHttpClient extends DioForNative {
  BaseHttpClient({
    @required String baseUri,
    BaseOptions options,
  }) : assert(baseUri != null), super(options) {
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    this.options.baseUrl = baseUri;
    this.options.connectTimeout = 180 * 1000;
    this.options.receiveTimeout = 180 * 1000;

    interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  void addInterceptors(List<Interceptor> interceptors) {
    this.interceptors.addAll(interceptors);
  }
}

dynamic parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void _parseAndDecode(String response) {
  return jsonDecode(response);
}
