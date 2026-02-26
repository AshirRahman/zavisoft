import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_app/core/model/user_profile.dart';
import '../repository/login_repository.dart';
import 'login_state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
  (ref) => LoginController(),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState());

  /// Login with username and password (API Call with Dummy Credentials)
  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Call the login API (supports dummy credentials: testuser/password123)
      final loginResponse = await LoginRepository.login(
        username: username,
        password: password,
      );

      // Create user profile from response
      final userProfile = UserProfile(
        id: 1,
        username: username,
        email: '$username@example.com',
        firstName: username,
        lastName: 'User',
      );

      state = state.copyWith(
        isLoggedIn: true,
        isLoading: false,
        token: loginResponse.token,
        loginResponse: loginResponse,
        userProfile: userProfile,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        userProfile: null,
      );
    }
  }

  /// Logout
  void logout() {
    state = LoginState();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true, userProfile: state.userProfile);
  }
}
