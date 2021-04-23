import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class Log extends ProviderObserver {
  // states
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 5, // number of method calls if stacktrace is provided
      lineLength: 40, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
  );

  // methods
  static void verbose<T>(T message) {
    _logger.v(message);
  }

  static void debug<T>(T message) {
    _logger.d(message);
  }

  static void info<T>(T message) {
    _logger.i(message);
  }

  static void warning<T>(T message, {Object exception, StackTrace stackTrace}) {
    _logger.w(message, exception, stackTrace);
  }

  static void error<T>(T message, {Object exception, StackTrace stackTrace}) {
    _logger.e(message, exception, stackTrace);
  }

  static void wtf<T>(T message, {Object exception, StackTrace stackTrace}) {
    _logger.wtf(message, exception, stackTrace);
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object newValue) {
    verbose("\n${provider.name ?? provider.runtimeType}\n");
  }
}
