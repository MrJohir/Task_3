/// api constants class for all api endpoints
class ApiConstants {
  ApiConstants._();

  // base url
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // endpoints
  static const String posts = '/posts';

  // methods
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';

  // headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // timeout
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
