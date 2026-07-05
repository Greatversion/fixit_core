import 'dart:async';

/// A named event with optional data payload and timestamp.
class FixitEvent {
  /// The event name used for routing and identification.
  final String name;

  /// Optional payload carried by the event.
  final dynamic data;

  /// The instant at which this event was created.
  final DateTime timestamp;

  /// Create an event with a [name] and an optional [data] payload.
  FixitEvent(this.name, [this.data]) : timestamp = DateTime.now();
}

/// A lightweight pub-sub event bus for loosely coupled communication.
///
/// Events are broadcast to all subscribers. Use [on<T>] to filter by type.
class FixitEventBus {
  final _controller = StreamController<FixitEvent>.broadcast();

  /// A raw stream of all events without filtering.
  Stream<FixitEvent> get stream => _controller.stream;

  /// Fire an [event] to all subscribers.
  void fire(FixitEvent event) {
    _controller.add(event);
  }

  /// Returns a typed stream that only emits events matching type [T].
  Stream<T> on<T>() {
    if (T == dynamic || T == FixitEvent) {
      return stream as Stream<T>;
    }
    return stream.where((event) => event is T).cast<T>();
  }

  /// Release internal resources. No events can be fired after this call.
  void dispose() {
    _controller.close();
  }
}
