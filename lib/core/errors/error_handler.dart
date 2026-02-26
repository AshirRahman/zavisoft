import 'package:dio/dio.dart';
import 'package:riverpod_app/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Failure handleError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const Failure('Connection timeout. Please check your internet.');
      case DioExceptionType.receiveTimeout:
        return const Failure(
            'Server took too long to respond. Please try again.');
      case DioExceptionType.sendTimeout:
        return const Failure('Request timeout. Please try again.');
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          return const Failure('Unauthorized request');
        }
        return Failure(
          'Server error: ${error.response?.statusCode ?? 'Unknown'}',
        );
      case DioExceptionType.connectionError:
        return const Failure(
            'No internet connection. Please check your network.');
      case DioExceptionType.unknown:
        return const Failure('An unexpected error occurred. Please try again.');
      default:
        return Failure('Error: ${error.message}');
    }
  }

  if (error is AuthException) {
    if (error.message.contains('Invalid login credentials')) {
      return const Failure('Wrong email or password');
    }
    return Failure(error.message);
  }

  if (error is Exception) {
    return Failure(error.toString().replaceAll('Exception: ', ''));
  }

  return const Failure('Something went wrong. Please try again.');
}
