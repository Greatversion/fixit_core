import 'dart:developer' as developer;

enum FixitLogLevel { debug, info, warning, error, performance }

class FixitLogger {
  final String label;

  FixitLogger({required this.label});

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

  void debug(String message) => log(message, level: FixitLogLevel.debug);
  void info(String message) => log(message, level: FixitLogLevel.info);
  void warning(String message) => log(message, level: FixitLogLevel.warning);
  void error(String message, {Object? err, StackTrace? stack}) => log(message, level: FixitLogLevel.error, error: err, stackTrace: stack);
  void performance(String message) => log(message, level: FixitLogLevel.performance);
}
