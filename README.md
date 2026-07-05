# Fixit Core

Core utilities for the Fixit Runtime SDK — logger, event bus, and version constants.

## Features

- **`FixitLogger`** — Lightweight logger with label support and debug/info/warning/error levels
- **`FixitEventBus`** — Simple pub/sub event bus for decoupled communication
- **`FixitVersion`** — SDK version constant

## Usage

```dart
import 'package:fixit_core/fixit_core.dart';

final logger = FixitLogger(label: 'MyApp');
logger.info('App started');

final bus = FixitEventBus();
bus.on('user.login', (data) => print('User logged in: $data'));
bus.emit('user.login', {'id': 42});
```

## License

MIT
