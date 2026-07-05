import 'package:fixit_core/fixit_core.dart';

void main() {
  // Logger usage
  final logger = FixitLogger(label: 'example');
  logger.info('Application started');
  logger.warning('This is a warning');
  logger.error('Something went wrong', err: Exception('test'));

  // Event bus usage
  final bus = FixitEventBus();
  bus.stream.listen((event) {
    logger.info('Received event: ${event.name}');
  });
  bus.fire(FixitEvent('user.login', {'userId': 42}));
  bus.dispose();

  // Version info
  logger.info('SDK version: ${FixitVersion.sdk}');
}
