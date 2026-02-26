// riverpod/lib/core/network/request_result.dart
sealed class RequestResult<T> {
  const RequestResult();
}

class Success<T> extends RequestResult<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends RequestResult<T> {
  final String message;
  const FailureResult(this.message);
}
