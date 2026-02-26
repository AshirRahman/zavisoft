import 'package:riverpod_app/core/network/api_client.dart';
import 'package:riverpod_app/core/network/api_endpoints.dart';
import 'package:riverpod_app/core/errors/error_handler.dart';
import 'package:riverpod_app/features/auth/login/model/login_model.dart';

class LoginRepository {
  /// Login with username and password (Dummy credentials support)
  static Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      // Dummy credentials - allow test login without API
      const dummyUsername = 'test';
      const dummyPassword = '12345';

      if (username == dummyUsername && password == dummyPassword) {
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 1500));

        // Return dummy token
        return LoginResponse(
          token: 'dummy_token_${DateTime.now().millisecondsSinceEpoch}',
        );
      }

      // Try real API call for non-dummy credentials
      final response = await ApiClient.post(
        ApiEndpoints.loginEndpoint,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      final failure = handleError(e);
      throw Exception(failure.message);
    }
  }
}
