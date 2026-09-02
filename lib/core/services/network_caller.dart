import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:boujee_employees/core/services/response_data.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'app_loger.dart';
import 'auth_service.dart';

class NetworkCaller {
  final int timeoutDuration = 30;

  // -----------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------

  /// Ensures URL contains a scheme and is parsed correctly
  Uri _parseUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    return Uri.parse(url);
  }

  /// Formats headers with Authorization and Content-Type
  Map<String, String> _getHeaders({String? token, bool isJson = true}) {
    final Map<String, String> headers = {};

    if (isJson) {
      headers['Content-Type'] = 'application/json';
    }

    final String? authToken = token ?? AuthService.token;
    if (authToken != null && authToken.isNotEmpty) {
      // Add 'Bearer ' prefix if not already present
      headers['Authorization'] = authToken.startsWith('Bearer ')
          ? authToken
          : 'Bearer $authToken';
    }

    return headers;
  }

  // -----------------------------------------------------------------------
  // Standard HTTP Requests
  // -----------------------------------------------------------------------

  Future<ResponseData> getRequest(String endpoint, {String? token}) async {
    final Uri url = _parseUrl(endpoint);
    AppLogger.info('GET Request: $url');

    try {
      final http.Response response = await http
          .get(url, headers: _getHeaders(token: token))
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  Future<ResponseData> postRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final Uri url = _parseUrl(endpoint);
    AppLogger.info('POST Request: $url');
    if (body != null) AppLogger.debug('Body: ${jsonEncode(body)}');

    try {
      final http.Response response = await http
          .post(
            url,
            headers: _getHeaders(token: token),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  Future<ResponseData> putRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final Uri url = _parseUrl(endpoint);
    AppLogger.info('PUT Request: $url');
    if (body != null) AppLogger.debug('Body: ${jsonEncode(body)}');

    try {
      final http.Response response = await http
          .put(
            url,
            headers: _getHeaders(token: token),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  Future<ResponseData> patchRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final Uri url = _parseUrl(endpoint);
    AppLogger.info('PATCH Request: $url');
    if (body != null) AppLogger.debug('Body: ${jsonEncode(body)}');

    try {
      final http.Response response = await http
          .patch(
            url,
            headers: _getHeaders(token: token),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  Future<ResponseData> deleteRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final Uri url = _parseUrl(endpoint);
    AppLogger.info('DELETE Request: $url');

    try {
      final http.Response response = await http
          .delete(
            url,
            headers: _getHeaders(token: token),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  // -----------------------------------------------------------------------
  // Multipart Requests
  // -----------------------------------------------------------------------

  /// Single image upload request
  Future<ResponseData> postImageRequest(
    String url, {
    required File file,
    String fileField = 'pickImage',
    String? token,
  }) async {
    return patchMultipart(
      url,
      fileField: fileField,
      file: file,
      token: token,
      method: 'POST',
    );
  }

  /// Single file multipart upload (PATCH/POST)
  Future<ResponseData> patchMultipart(
    String url, {
    required String fileField,
    required File file,
    String? token,
    String method = 'PATCH',
  }) async {
    try {
      final Uri parsedUrl = _parseUrl(url);
      AppLogger.info('$method Multipart Single: $parsedUrl');

      final request = http.MultipartRequest(method, parsedUrl);
      request.headers.addAll(_getHeaders(token: token, isJson: false));

      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      final mimeTypeSplit = mimeType.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          fileField,
          file.path,
          contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
        ),
      );

      final streamed = await request.send().timeout(
        Duration(seconds: timeoutDuration),
      );
      final response = await http.Response.fromStream(streamed);

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  /// Multiple files + text fields
  Future<ResponseData> patchMultipartMultipleFiles(
    String url, {
    required String fileField,
    required List<File> files,
    Map<String, String>? extraFields,
    String? token,
    String method = 'PATCH',
  }) async {
    try {
      final Uri parsedUrl = _parseUrl(url);
      AppLogger.info('$method Multipart Multiple: $parsedUrl');

      final request = http.MultipartRequest(method, parsedUrl);
      request.headers.addAll(_getHeaders(token: token, isJson: false));

      if (extraFields != null) {
        request.fields.addAll(extraFields);
      }

      for (final File file in files) {
        final String? mimeType = lookupMimeType(file.path);
        final MediaType? contentType = mimeType != null
            ? MediaType.parse(mimeType)
            : null;

        request.files.add(
          await http.MultipartFile.fromPath(
            fileField,
            file.path,
            contentType: contentType,
          ),
        );
      }

      final streamedResponse = await request.send().timeout(
        Duration(seconds: timeoutDuration),
      );
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  /// Multipart with embedded JSON payload field
  Future<ResponseData> multipartJsonRequest({
    required String url,
    required String method,
    required Map<String, dynamic> bodyData,
    Map<String, dynamic>? files,
    String? token,
    String jsonFieldName = 'bodyData',
  }) async {
    try {
      final Uri parsedUrl = _parseUrl(url);
      AppLogger.info('$method Multipart JSON: $parsedUrl');

      final request = http.MultipartRequest(method, parsedUrl);
      request.headers.addAll(_getHeaders(token: token, isJson: false));

      request.fields[jsonFieldName] = jsonEncode(bodyData);

      if (files != null) {
        for (final entry in files.entries) {
          final key = entry.key;
          final value = entry.value;

          if (value == null) continue;

          if (value is File) {
            final mimeType =
                lookupMimeType(value.path) ?? 'application/octet-stream';
            final parts = mimeType.split('/');

            request.files.add(
              await http.MultipartFile.fromPath(
                key,
                value.path,
                contentType: MediaType(parts[0], parts[1]),
              ),
            );
          } else if (value is List<File>) {
            for (final file in value) {
              final mimeType =
                  lookupMimeType(file.path) ?? 'application/octet-stream';
              final parts = mimeType.split('/');

              request.files.add(
                await http.MultipartFile.fromPath(
                  key,
                  file.path,
                  contentType: MediaType(parts[0], parts[1]),
                ),
              );
            }
          }
        }
      }

      final streamedResponse = await request.send().timeout(
        Duration(seconds: timeoutDuration),
      );
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } catch (e, stackTrace) {
      return _handleError(e, stackTrace);
    }
  }

  // -----------------------------------------------------------------------
  // Response & Error Parsers
  // -----------------------------------------------------------------------

  Future<ResponseData> _handleResponse(http.Response response) async {
    final int statusCode = response.statusCode;
    AppLogger.info('Response Code: $statusCode');

    dynamic decodedResponse;
    if (response.body.isNotEmpty) {
      try {
        decodedResponse = jsonDecode(response.body);
        AppLogger.debug('Response Body: $decodedResponse');
      } catch (_) {
        decodedResponse = response.body;
      }
    }

    // Auto log out user on unauthorized access
    if (statusCode == 401) {
      AppLogger.warning('401 Unauthorized - Triggering logout');
      await AuthService.logoutUser();
    }

    if (statusCode >= 200 && statusCode <= 299) {
      return ResponseData(
        isSuccess: true,
        statusCode: statusCode,
        errorMessage: '',
        responseData: decodedResponse,
      );
    }

    // Extract custom error message from server response if available
    String serverErrorMessage =
        _extractServerErrorMessage(decodedResponse) ??
        _getFallbackErrorMessage(statusCode);

    return ResponseData(
      isSuccess: false,
      statusCode: statusCode,
      errorMessage: serverErrorMessage,
      responseData: decodedResponse,
    );
  }

  /// Extracts error message from standard API JSON payloads
  String? _extractServerErrorMessage(dynamic decodedJson) {
    if (decodedJson is Map<String, dynamic>) {
      if (decodedJson.containsKey('message') &&
          decodedJson['message'] != null) {
        return decodedJson['message'].toString();
      }
      if (decodedJson.containsKey('error') && decodedJson['error'] != null) {
        return decodedJson['error'].toString();
      }
    }
    return null;
  }

  String _getFallbackErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Unauthorized session. Please log in again.';
      case 403:
        return 'Access forbidden.';
      case 404:
        return 'Resource not found.';
      case 409:
        return 'Conflict occurred.';
      case 422:
        return 'Validation error occurred.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred.';
    }
  }

  ResponseData _handleError(dynamic error, [StackTrace? stackTrace]) {
    AppLogger.error('Network Error', error: error, stackTrace: stackTrace);

    if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        errorMessage:
            'Request timed out. Please check your connection and try again.',
        responseData: null,
      );
    } else if (error is SocketException || error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 503,
        errorMessage:
            'Network error occurred. Please check your connection and try again.',
        responseData: null,
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage: 'Something went wrong. Please try again later.',
        responseData: null,
      );
    }
  }
}
