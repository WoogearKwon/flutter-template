import 'dart:io';

import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

import 'interceptors.dart';

/// API 통신 시 공통 요청 Header 처리를 위한 Base 클래스
///
/// [onRequest] 콜백에서 아래의 공통 헤더를 설정한다.
/// App-Version
/// Device-Id
/// Os-Type
/// Os-Version
class BaseApiHeaderInterceptor extends BaseHeaderInterceptor {
  @override
  Future onRequest(RequestOptions options) async {
    /// 앱 버전 정보 추가
    final packageInfo = await _loadPackageInfo();
    options.headers['App-Version'] = packageInfo['version'];

    /// 디바이스 정보 추가
    final deviceInfo = await _loadDeviceInfo();
    options.headers['Device-Id'] = deviceInfo['uuid'];
    options.headers['Os-Type'] = deviceInfo['operatingSystem'];
    options.headers['Os-Version'] = deviceInfo['operatingSystemVersion'];

    return super.onRequest(options);
  }

  Future<Map<String, String>> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    return {
      'packageName': info.packageName,
      'appName': info.appName,
      'version': info.version,
      'buildNumber': info.buildNumber,
    };
  }

  Future<Map<String, String>> _loadDeviceInfo() async {
    final device = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await device.androidInfo;

      return {
        'uuid': info.androidId,
        'operatingSystem': 'Android',
        'operatingSystemVersion': info.version.sdkInt.toString(),
      };
    } else {
      final info = await device.iosInfo;

      return {
        'uuid': info.identifierForVendor,
        'operatingSystem': 'iOS',
        'operatingSystemVersion': info.systemVersion,
      };
    }
  }
}
