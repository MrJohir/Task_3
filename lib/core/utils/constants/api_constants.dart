/// api constants class for managing all API endpoints and configurations
class ApiConstants {
  // base url
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  
  // endpoints
  static const String posts = '/posts';
  static const String users = '/users';
  static const String comments = '/comments';
  
  // full endpoints
  static const String createPost = '$baseUrl$posts';
  static const String updatePost = '$baseUrl$posts'; // append /{id}
  static const String deletePost = '$baseUrl$posts'; // append /{id}
  static const String getPost = '$baseUrl$posts'; // append /{id}
  static const String getAllPosts = '$baseUrl$posts';
  
  // timeout values
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };
  
  // api response codes
  static const int success = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;
  
  // retry configuration
  static const int maxRetryAttempts = 3;
  static const int retryDelaySeconds = 2;
}