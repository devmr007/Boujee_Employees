import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to display
      errorMethodCount: 8, // Number of method calls if error is present
      lineLength: 100, // Width of the log line output
      colors: true, // Colorize output in terminal
      printEmojis: true, // Print emojis for visual identification
      dateTimeFormat: DateTimeFormat.dateAndTime, // Show timestamp
    ),
    // Suppress trace/debug logs in release mode automatically
    level: kReleaseMode ? Level.warning : Level.trace,
  );

  /// Fine-grained tracing (e.g. execution flow, raw data dumps)
  static void trace(Object? message) {
    _logger.t(message);
  }

  /// Development debug logs
  static void debug(Object? message) {
    _logger.d(message);
  }

  /// General application informational events
  static void info(Object? message) {
    _logger.i(message);
  }

  /// Non-critical warnings
  static void warning(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Handled errors with error object and stack traces
  static void error(Object? message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace ?? (error != null ? StackTrace.current : null),
    );
  }

  /// Fatal app errors or unrecoverable crashes
  static void fatal(Object? message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(
      message,
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
}
