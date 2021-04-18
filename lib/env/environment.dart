import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_template/barrel.dart';

class Environment {
  static Environment _instance;

  static Environment get instance => _instance;

  final BuildType buildType;

  static String get api {
    switch (instance.buildType) {
      case BuildType.debug:
        return 'http://deveopment.base.url';

      case BuildType.release:
        return 'http://release.base.url';

      default:
        throw UnsupportedError('Unsupported Build Type Error');
    }
  }

  const Environment._internal(this.buildType);

  factory Environment.newInstance(BuildType buildType) {
    assert(buildType != null);

    _instance ??= Environment._internal(buildType);
    return _instance;
  }

  void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Setup screen orientation lock
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// Setup system status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    /// Preview: Smooth scrolling for unmatched input and display frequencies
    GestureBinding.instance.resamplingEnabled = true;

    /// Setup Local DataSorage
    await Hive.initFlutter();
    await Hive.openBox(BoxContract.name);

    /// Setup Service Locator
    await Injector.install();

    /// Setup Logger
    Logger.newInstance(kDebugMode);

    /// Setup BlocObserver
    Bloc.observer = Injector.blocObserver;

    /// Setup Router
    Routes.init(Injector.router);

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<UiBloc>(
            create: (context) => UiBloc(),
          ),
        ],
        child: Application(
          navigatorKey: Injector.navigatorKey,
          routeFactory: Injector.router.generator,
        ),
      ),
    );
  }
}
