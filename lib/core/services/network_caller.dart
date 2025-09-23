import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_3/core/utils/constants/api_constants.dart';
import 'package:task_3/core/utils/logging/logger.dart';

/// network caller service for api requests
class NetworkCaller {
  static final NetworkCaller _instance = NetworkCaller._internal();
  factory NetworkCaller() => _instance;
  NetworkCaller._internal();

  /// make get request
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      AppLogger.info('GET Request: $uri');

      final response = await http
          .get(
            uri,
            headers: {...ApiConstants.headers, if (headers != null) ...headers},
          )
          .timeout(ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      AppLogger.error('No internet connection');
      throw Exception('No internet connection');
    } on HttpException catch (e) {
      AppLogger.error('HTTP Exception: ${e.message}');
      throw Exception('HTTP error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  /// make post request
  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      AppLogger.info('POST Request: $uri');
      AppLogger.info('POST Body: $body');

      final response = await http
          .post(
            uri,
            headers: {...ApiConstants.headers, if (headers != null) ...headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      AppLogger.error('No internet connection');
      throw Exception('No internet connection');
    } on HttpException catch (e) {
      AppLogger.error('HTTP Exception: ${e.message}');
      throw Exception('HTTP error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  /// make put request
  Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      AppLogger.info('PUT Request: $uri');
      AppLogger.info('PUT Body: $body');

      final response = await http
          .put(
            uri,
            headers: {...ApiConstants.headers, if (headers != null) ...headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      AppLogger.error('No internet connection');
      throw Exception('No internet connection');
    } on HttpException catch (e) {
      AppLogger.error('HTTP Exception: ${e.message}');
      throw Exception('HTTP error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  /// make delete request
  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      AppLogger.info('DELETE Request: $uri');

      final response = await http
          .delete(
            uri,
            headers: {...ApiConstants.headers, if (headers != null) ...headers},
          )
          .timeout(ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      AppLogger.error('No internet connection');
      throw Exception('No internet connection');
    } on HttpException catch (e) {
      AppLogger.error('HTTP Exception: ${e.message}');
      throw Exception('HTTP error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  /// handle http response
  Map<String, dynamic> _handleResponse(http.Response response) {
    AppLogger.info('Response Status: ${response.statusCode}');
    AppLogger.info('Response Body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }

      try {
        return jsonDecode(response.body);
      } catch (e) {
        AppLogger.error('Failed to parse response body: $e');
        throw Exception('Failed to parse response');
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}';

      try {
        final errorBody = jsonDecode(response.body);
        if (errorBody['message'] != null) {
          errorMessage = errorBody['message'];
        }
      } catch (e) {
        AppLogger.warning('Could not parse error response');
      }

      AppLogger.error(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
