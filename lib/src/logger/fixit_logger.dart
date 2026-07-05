import 'dart:developer' as developer;

/// Severity levels supported by [FixitLogger].
enum FixitLogLevel {
  /// Detailed information typically useful only for debugging.
  debug,
  /// General informational messages about application progress.
  info,
  /// Potentially harmful situations that warrant attention.
  warning,
  /// Error events that might still allow the application to continue.
  error,
  /// Timing and performance metrics.
  performance,
}

/// A lightweight structured logger that wraps `dart:developer` logging.
///
/// Each logger is labelled so messages can be traced back to their source.
class FixitLogger {
  /// Label identifying the source of log messages (e.g. a module or component name).
  final String label;

  /// Create a logger with the given [label].
  FixitLogger({required this.label});

  /// Log a [message] at the given [level] with optional [error] and [stackTrace].
  void log(String message, {FixitLogLevel level = FixitLogLevel.debug, Object? error, StackTrace? stackTrace}) {
    final levelStr = level.toString().split('.').last.toUpperCase();
    final time = DateTime.now().toIso8601String();
    final formattedMessage = '[$time] [$levelStr] [$label] $message';

    switch (level) {
      case FixitLogLevel.debug:
        developer.log(formattedMessage, name: 'FixitSDK', error: error, stackTrace: stackTrace);
        break;
      case FixitLogLevel.info:
        developer.log(formattedMessage, name: 'FixitSDK', level: 700, error: error, stackTrace: stackTrace);
        break;
      case FixitLogLevel.warning:
        developer.log(formattedMessage, name: 'FixitSDK', level: 900, error: error, stackTrace: stackTrace);
        break;
      case FixitLogLevel.error:
        developer.log(formattedMessage, name: 'FixitSDK', level: 1000, error: error, stackTrace: stackTrace);
        break;
      case FixitLogLevel.performance:
        developer.log(formattedMessage, name: 'FixitSDK', level: 800, error: error, stackTrace: stackTrace);
        break;
    }
  }

  /// Log a debug-level [message].
  void debug(String message) => log(message, level: FixitLogLevel.debug);

  /// Log an info-level [message].
  void info(String message) => log(message, level: FixitLogLevel.info);

  /// Log a warning-level [message].
  void warning(String message) => log(message, level: FixitLogLevel.warning);

  /// Log an error-level [message] with optional [err] and [stack] trace.
  void error(String message, {Object? err, StackTrace? stack}) => log(message, level: FixitLogLevel.error, error: err, stackTrace: stack);

  /// Log a performance-level [message] (e.g. timing metrics).
  void performance(String message) => log(message, level: FixitLogLevel.performance);
}
