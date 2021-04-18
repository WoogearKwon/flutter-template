import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/bloc/observer.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'barrel.dart';

class Injector {
  Injector._();

  static GetIt get _instance => GetIt.instance;

  static GlobalKey<NavigatorState> get navigatorKey =>
      _instance.get<GlobalKey<NavigatorState>>();

  static Box get preferences => Hive.box(BoxContract.name);

  static FluroRouter get router => _instance.get<FluroRouter>();

  static Dio get apiClient =>
      _instance.get<Dio>(instanceName: Qualifier.apiClient.rawValue);

  static Dio get tokenClient =>
      _instance.get<Dio>(instanceName: Qualifier.tokenClient.rawValue);

  static BlocObserver get blocObserver => _instance.get<BlocObserver>();

  static Future install() async {
    _installFlutter();
    _installThirdParty();
    _installNetwork();
    _installDataSources();
    _installStateManagement();
  }

  static void _installFlutter() {
    _instance.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>(),
    );
  }

  static void _installThirdParty() {
    _instance.registerSingleton<FluroRouter>(FluroRouter());
  }

  static void _installNetwork() {
    _instance.registerFactory<Dio>(
      () => ApiClient(),
      instanceName: Qualifier.apiClient.rawValue,
    );
  }

  static void _installDataSources() {}

  static void _installStateManagement() {
    _instance.registerSingleton<BlocObserver>(AppBlocObserver());
  }
}
