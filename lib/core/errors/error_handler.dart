import 'package:dio/dio.dart';
import 'package:riverpod_app/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Failure handleError(dynamic error) {
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionError) {
      return const Failure('No internet connection');
    }
    if (error.response?.statusCode == 401) {
      return const Failure('Unauthorized request');
    }
    return const Failure('Server error occurred');
  }

  if (error is AuthException) {
    if (error.message.contains('Invalid login credentials')) {
      return const Failure('Wrong email or password');
    }
    return Failure(error.message);
  }

  return const Failure('Something went wrong. Please try again.');
}
