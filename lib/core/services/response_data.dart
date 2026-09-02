class ResponseData {
  final bool isSuccess;
  final int statusCode;
  final String errorMessage;
  final dynamic responseData;

  const ResponseData({
    required this.isSuccess,
    required this.statusCode,
    required this.errorMessage,
    required this.responseData,
  });

  // -----------------------------------------------------------------------
  // Factory Constructors
  // -----------------------------------------------------------------------

  /// Convenience constructor for successful responses
  factory ResponseData.success({
    required dynamic responseData,
    int statusCode = 200,
  }) {
    return ResponseData(
      isSuccess: true,
      statusCode: statusCode,
      errorMessage: '',
      responseData: responseData,
    );
  }

  /// Convenience constructor for failed responses
  factory ResponseData.error({
    required String errorMessage,
    int statusCode = 500,
    dynamic responseData,
  }) {
    return ResponseData(
      isSuccess: false,
      statusCode: statusCode,
      errorMessage: errorMessage,
      responseData: responseData,
    );
  }

  // -----------------------------------------------------------------------
  // Display Message Extractor
  // -----------------------------------------------------------------------

  /// Returns the best available human-readable message.
  /// Priority: server 'message'/'error' field -> errorMessage -> generic fallback
  String get displayMessage {
    if (responseData != null && responseData is Map) {
      final serverMessage = responseData['message'] ?? responseData['error'];

      if (serverMessage != null) {
        // Handles array error messages like ["Error 1", "Error 2"]
        if (serverMessage is List) {
          final joined = serverMessage
              .where((e) => e != null)
              .map((e) => e.toString().trim())
              .where((e) => e.isNotEmpty)
              .join('\n');
          if (joined.isNotEmpty) return joined;
        }

        final msgStr = serverMessage.toString().trim();
        if (msgStr.isNotEmpty) return msgStr;
      }
    }

    if (errorMessage.trim().isNotEmpty) {
      return errorMessage;
    }

    return 'Something went wrong. Please try again.';
  }

  // -----------------------------------------------------------------------
  // Type Safety Helpers
  // -----------------------------------------------------------------------

  /// Returns responseData safely as a Map if valid
  Map<String, dynamic>? get dataAsMap =>
      responseData is Map<String, dynamic> ? responseData : null;

  /// Returns responseData safely as a List if valid
  List<dynamic>? get dataAsList => responseData is List ? responseData : null;

  // -----------------------------------------------------------------------
  // HTTP Status Getters
  // -----------------------------------------------------------------------

  bool get isTimeout => statusCode == 408;
  bool get isServerError => statusCode >= 500;
  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isValidationError => statusCode == 422;

  @override
  String toString() =>
      'ResponseData(isSuccess: $isSuccess, statusCode: $statusCode, '
      'errorMessage: $errorMessage, responseData: $responseData)';
}
