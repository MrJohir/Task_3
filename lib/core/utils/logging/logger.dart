import 'package:logger/logger.dart';

/// custom logger class for application logging
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// log debug message
  /// [message] - Debug message to log
  /// [error] - Optional error object
  /// [stackTrace] - Optional stack trace
  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// log info message
  /// [message] - Info message to log
  /// [error] - Optional error object
  /// [stackTrace] - Optional stack trace
  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// log warning message
  /// [message] - Warning message to log
  /// [error] - Optional error object
  /// [stackTrace] - Optional stack trace
  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// log error message
  /// [message] - Error message to log
  /// [error] - Optional error object
  /// [stackTrace] - Optional stack trace
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// log wtf (what a terrible failure) message
  /// [message] - WTF message to log
  /// [error] - Optional error object
  /// [stackTrace] - Optional stack trace
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// log api request
  /// [method] - HTTP method
  /// [url] - Request URL
  /// [headers] - Request headers
  /// [body] - Request body
  static void apiRequest(String method, String url, [Map<String, dynamic>? headers, dynamic body]) {
    info('🌐 API Request: $method $url');
    if (headers != null) debug('📝 Headers: $headers');
    if (body != null) debug('📦 Body: $body');
  }

  /// log api response
  /// [statusCode] - Response status code
  /// [url] - Request URL
  /// [response] - Response data
  static void apiResponse(int statusCode, String url, [dynamic response]) {
    if (statusCode >= 200 && statusCode < 300) {
      info('✅ API Response: $statusCode $url');
    } else {
      error('❌ API Error: $statusCode $url');
    }
    if (response != null) debug('📥 Response: $response');
  }

  /// log api error
  /// [url] - Request URL
  /// [error] - Error object
  /// [stackTrace] - Optional stack trace
  static void apiError(String url, dynamic error, [StackTrace? stackTrace]) {
    AppLogger.error('🚫 API Error: $url', error, stackTrace);
  }

  /// log database operation
  /// [operation] - Database operation type
  /// [table] - Database table/box name
  /// [data] - Optional data
  static void database(String operation, String table, [dynamic data]) {
    info('💾 Database: $operation on $table');
    if (data != null) debug('📊 Data: $data');
  }

  /// log sync operation
  /// [message] - Sync message
  /// [data] - Optional sync data
  static void sync(String message, [dynamic data]) {
    info('🔄 Sync: $message');
    if (data != null) debug('📋 Data: $data');
  }

  /// log navigation
  /// [route] - Route name
  /// [arguments] - Optional route arguments
  static void navigation(String route, [dynamic arguments]) {
    info('🧭 Navigation: $route');
    if (arguments != null) debug('📝 Arguments: $arguments');
  }

  /// log user action
  /// [action] - User action description
  /// [data] - Optional action data
  static void userAction(String action, [dynamic data]) {
    info('👤 User Action: $action');
    if (data != null) debug('📋 Data: $data');
  }
}