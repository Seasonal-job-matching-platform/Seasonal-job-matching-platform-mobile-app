import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class AppLogger {
  static void debug(String message, {String tag = 'DEBUG'}) {
    if (kDebugMode) {
      developer.log(message, name: tag);
    }
  }

  static void info(String message, {String tag = 'INFO'}) {
    if (kDebugMode) {
      developer.log(message, name: tag);
    }
  }

  static void warning(String message, {String tag = 'WARNING'}) {
    if (kDebugMode) {
      developer.log(message, name: tag);
    }
  }

  static void error(String message, {String tag = 'ERROR', Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: tag, error: error, stackTrace: stackTrace);
    }
  }
}
