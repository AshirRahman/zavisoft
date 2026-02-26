import 'package:riverpod_app/core/config/env.dart';

class ApiEndpoints {
  static String get baseUrl => Env.apiBaseUrl;
  static String get loginEndpoint => '$baseUrl/auth/login';
  static String get usersEndpoint => '$baseUrl/users';
  static String get productsEndpoint => '$baseUrl/products';
}
