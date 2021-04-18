import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/barrel.dart';

export 'package:fluro/fluro.dart';

part 'paths.dart';

part 'navigator.dart';

part 'handler.dart';

class Routes {
  static FluroRouter _router;

  static FluroRouter get router => _router;

  Routes._();

  static void init(FluroRouter router) {
    _router ??= router;
    _defines();
  }

  static void _defines() {
    /// Flutter Default 화면
    _router.define(Path.root, handler: rootHandler);
  }
}
