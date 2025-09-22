import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants/api_constants.dart';
import '../utils/logging/logger.dart';

/// network caller service for handling API requests
class NetworkCaller {
  static final NetworkCaller _instance = NetworkCaller._internal();
  factory NetworkCaller() => _instance;
  NetworkCaller._internal();

  /// make GET request
  /// [url] - Request URL
  /// [headers] - Optional headers
  /// Returns: Response data or throws exception
  static Future<Map<String, dynamic>> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      AppLogger.apiRequest('GET', url, headers);
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          ...ApiConstants.defaultHeaders,
          if (headers != null) ...headers,
        },
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectionTimeout),
      );

      AppLogger.apiResponse(response.statusCode, url, response.body);
      
      return _handleResponse(response);
    } catch (error, stackTrace) {
      AppLogger.apiError(url, error, stackTrace);
      rethrow;
    }
  }

  /// make POST request
  /// [url] - Request URL
  /// [body] - Request body
  /// [headers] - Optional headers
  /// Returns: Response data or throws exception
  static Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      AppLogger.apiRequest('POST', url, headers, body);
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          ...ApiConstants.defaultHeaders,
          if (headers != null) ...headers,
        },
        body: jsonEncode(body),
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectionTimeout),
      );

      AppLogger.apiResponse(response.statusCode, url, response.body);
      
      return _handleResponse(response);
    } catch (error, stackTrace) {
      AppLogger.apiError(url, error, stackTrace);
      rethrow;
    }
  }

  /// make PUT request
  /// [url] - Request URL
  /// [body] - Request body
  /// [headers] - Optional headers
  /// Returns: Response data or throws exception
  static Future<Map<String, dynamic>> putRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      AppLogger.apiRequest('PUT', url, headers, body);
      
      final response = await http.put(
        Uri.parse(url),
        headers: {
          ...ApiConstants.defaultHeaders,
          if (headers != null) ...headers,
        },
        body: jsonEncode(body),
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectionTimeout),
      );

      AppLogger.apiResponse(response.statusCode, url, response.body);
      
      return _handleResponse(response);
    } catch (error, stackTrace) {
      AppLogger.apiError(url, error, stackTrace);
      rethrow;
    }
  }

  /// make DELETE request
  /// [url] - Request URL
  /// [headers] - Optional headers
  /// Returns: Response data or throws exception
  static Future<Map<String, dynamic>> deleteRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      AppLogger.apiRequest('DELETE', url, headers);
      
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          ...ApiConstants.defaultHeaders,
          if (headers != null) ...headers,
        },
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectionTimeout),
      );

      AppLogger.apiResponse(response.statusCode, url, response.body);
      
      return _handleResponse(response);
    } catch (error, stackTrace) {
      AppLogger.apiError(url, error, stackTrace);
      rethrow;
    }
  }

  /// handle HTTP response
  /// [response] - HTTP response object
  /// Returns: Parsed response data
  /// Throws: Exception for error status codes
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    
    // parse response body
    Map<String, dynamic> responseData;
    try {
      responseData = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      // if response is not JSON, create a simple structure
      responseData = {'data': response.body};
    }

    // handle different status codes
    switch (statusCode) {
      case ApiConstants.success:
      case ApiConstants.created:
      case ApiConstants.noContent:
        return responseData;
        
      case ApiConstants.badRequest:
        throw BadRequestException(
          message: responseData['message'] ?? 'Bad request',
          statusCode: statusCode,
        );
        
      case ApiConstants.unauthorized:
        throw UnauthorizedException(
          message: responseData['message'] ?? 'Unauthorized access',
          statusCode: statusCode,
        );
        
      case ApiConstants.forbidden:
        throw ForbiddenException(
          message: responseData['message'] ?? 'Access forbidden',
          statusCode: statusCode,
        );
        
      case ApiConstants.notFound:
        throw NotFoundException(
          message: responseData['message'] ?? 'Resource not found',
          statusCode: statusCode,
        );
        
      case ApiConstants.internalServerError:
        throw ServerException(
          message: responseData['message'] ?? 'Internal server error',
          statusCode: statusCode,
        );
        
      default:
        if (statusCode >= 400 && statusCode < 500) {
          throw ClientException(
            message: responseData['message'] ?? 'Client error occurred',
            statusCode: statusCode,
          );
        } else if (statusCode >= 500) {
          throw ServerException(
            message: responseData['message'] ?? 'Server error occurred',
            statusCode: statusCode,
          );
        } else {
          return responseData;
        }
    }
  }
}

/// base exception class for network errors
abstract class NetworkException implements Exception {
  final String message;
  final int statusCode;

  const NetworkException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => 'NetworkException: $message (Status: $statusCode)';
}

/// exception for bad request (400)
class BadRequestException extends NetworkException {
  const BadRequestException({
    required super.message,
    required super.statusCode,
  });
}

/// exception for unauthorized access (401)
class UnauthorizedException extends NetworkException {
  const UnauthorizedException({
    required super.message,
    required super.statusCode,
  });
}

/// exception for forbidden access (403)
class ForbiddenException extends NetworkException {
  const ForbiddenException({
    required super.message,
    required super.statusCode,
  });
}

/// exception for not found (404)
class NotFoundException extends NetworkException {
  const NotFoundException({
    required super.message,
    required super.statusCode,
  });
}

/// exception for client errors (4xx)
class ClientException extends NetworkException {
  const ClientException({
    required super.message,
    required super.statusCode,
  });
}

/// exception for server errors (5xx)
class ServerException extends NetworkException {
  const ServerException({
    required super.message,
    required super.statusCode,
  });
}

/// exception for network connectivity issues
class ConnectivityException implements Exception {
  final String message;

  const ConnectivityException({required this.message});

  @override
  String toString() => 'ConnectivityException: $message';
}

/// exception for timeout errors
class TimeoutException implements Exception {
  final String message;

  const TimeoutException({required this.message});

  @override
  String toString() => 'TimeoutException: $message';
}