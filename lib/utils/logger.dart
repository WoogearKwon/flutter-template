import 'package:logger/logger.dart' as plugin;

class Logger {
  final plugin.Logger _logger;
  final bool useLogger;

  static Logger _instance;

  static Logger get instance => _instance;

  Logger._(this.useLogger) : _logger = useLogger ? plugin.Logger() : null;

  factory Logger.newInstance([bool useLogger = false]) {
    _instance ??= Logger._(useLogger);

    return _instance;
  }

  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log(plugin.Level.verbose, message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log(plugin.Level.debug, message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log(plugin.Level.info, message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log(plugin.Level.warning, message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log(plugin.Level.error, message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log(plugin.Level.wtf, message, error, stackTrace);
  }

  static void _log(
    plugin.Level level,
    dynamic message, [
    dynamic error,
    StackTrace stackTrace,
  ]) {
    if (_instance == null || _instance._logger == null) return;

    _instance._logger.log(level, message, error, stackTrace);
  }
}
