import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:flutter_template/barrel.dart';

import 'base/interceptors.dart';

class ApiHeaderInterceptor extends BaseApiHeaderInterceptor {
  final Dio apiClient;
  final Dio tokenClient;
  final Box preferences;
  final GlobalKey<NavigatorState> navigatorKey;

  ApiHeaderInterceptor({
    @required this.apiClient,
    @required this.tokenClient,
    @required this.preferences,
    @required this.navigatorKey,
  })  : assert(apiClient != null),
        assert(tokenClient != null),
        assert(preferences != null),
        assert(navigatorKey != null);

  @override
  Future onRequest(RequestOptions options) async {
    /// AccessToken 정보 추가
    final accessToken = await _getAccessToken();
    options.headers['Authorization'] = accessToken;

    return super.onRequest(options);
  }

  @override
  Future onError(DioError error) async {
    if (!_isTokenExpired(error)) {
      Logger.e('[onError]::토큰이 만료되지 않았으므로 error 를 그대로 반환한다.');
      return super.onError(error);
    }

    try {
      apiClient.interceptors.errorLock.lock();
      apiClient.interceptors.requestLock.lock();

      final requestOptions = error.response.request;
      final previousToken = error.request.headers['Authorization'];
      final currentToken = await _getAccessToken();
      if (previousToken != currentToken) {
        Logger.d('[onError]::이미 토큰이 갱신 되었으므로 요청을 재개한다.');
        return apiClient.request(requestOptions.path, options: requestOptions);
      }
      //
      // final requestData = TokenRefreshRequest(
      //   clientId: Environment.apiClientId,
      //   clientSecret: Environment.apiClientSecret,
      //   refreshToken: await _getRefreshToken(),
      // );
      //
      // final response = await tokenClient.post(
      //   '/auth/refresh',
      //   data: requestData.toJson(),
      //   options: Options(contentType: Headers.formUrlEncodedContentType),
      // );
      //
      // final authToken = AuthToken.fromJson(response.data);
      // await setAuthToken(authToken);
      Logger.d('[onError]::토큰이 갱신되었으므로 ${requestOptions.path} 재요청.');
      return apiClient.request(requestOptions.path, options: requestOptions);
    } catch (error) {
      return super.onError(error);
    } finally {
      apiClient.interceptors.errorLock.unlock();
      apiClient.interceptors.requestLock.unlock();
    }
  }

  bool _isTokenExpired(DioError error) =>
      error.request.baseUrl == Environment.api &&
      error.response != null &&
      error.response.statusCode == 401;

  Future<String> _getAccessToken() async {
    final token = await preferences.get(BoxContract.accessToken);
    Logger.d('[AccessToken]::$token');
    return token;
  }

  Future<String> _getRefreshToken() async {
    final token = await preferences.get(BoxContract.refreshToken);
    Logger.d('[RefreshToken]::$token');
    return token;
  }
}
