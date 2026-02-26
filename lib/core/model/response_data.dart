class ResponseData {
  final bool isSuccess;
  final int statusCode;
  final String errorMessage;
  final dynamic responseData;

  ResponseData({
    required this.isSuccess,
    required this.statusCode,
    required this.errorMessage,
    required this.responseData,
  });

  /// Factory constructor for success response
  factory ResponseData.success({
    required dynamic data,
    int statusCode = 200,
  }) {
    return ResponseData(
      isSuccess: true,
      statusCode: statusCode,
      errorMessage: '',
      responseData: data,
    );
  }

  /// Factory constructor for error response
  factory ResponseData.error({
    required String message,
    int statusCode = 500,
  }) {
    return ResponseData(
      isSuccess: false,
      statusCode: statusCode,
      errorMessage: message,
      responseData: null,
    );
  }
}
