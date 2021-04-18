import 'package:flutter_template/barrel.dart';

import 'base_client.dart';

class ApiClient extends BaseHttpClient {
  ApiClient({
    BaseOptions options,
  }) : super(baseUri: Environment.api, options: options) {
    final headerInterceptor = ApiHeaderInterceptor(
      apiClient: this,
      tokenClient: Injector.tokenClient,
      preferences: Injector.preferences,
      navigatorKey: Injector.navigatorKey,
    );

    addInterceptors([headerInterceptor]);
  }
}
