import 'package:dio/dio.dart';
import 'package:flutter_template/barrel.dart';

class BaseHeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    return super.onError(err);
  }
}
