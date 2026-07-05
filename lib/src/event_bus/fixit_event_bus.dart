import 'dart:async';

class FixitEvent {
  final String name;
  final dynamic data;
  final DateTime timestamp;

  FixitEvent(this.name, [this.data]) : timestamp = DateTime.now();
}

class FixitEventBus {
  final _controller = StreamController<FixitEvent>.broadcast();

  Stream<FixitEvent> get stream => _controller.stream;

  void fire(FixitEvent event) {
    _controller.add(event);
  }

  Stream<T> on<T>() {
    if (T == dynamic || T == FixitEvent) {
      return stream as Stream<T>;
    }
    return stream.where((event) => event is T).cast<T>();
  }

  void dispose() {
    _controller.close();
  }
}
