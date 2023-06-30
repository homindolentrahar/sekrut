import 'package:logger/logger.dart';

class LogHelper {
  late Logger _logger;

  static LogHelper instance = LogHelper._();

  LogHelper._() {
    _logger = Logger();
  }

  void debug({StackTrace? trace, required String message}) {
    _logger.d(message, trace);
  }

  void info({StackTrace? trace, required String message}) {
    _logger.i(message, trace);
  }

  void error({StackTrace? trace, required String message}) {
    _logger.e(message, trace);
  }

  void warning({StackTrace? trace, required String message}) {
    _logger.w(message, trace);
  }
}
