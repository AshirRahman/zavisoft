import 'package:riverpod_app/features/auth/login/model/login_model.dart';
import 'package:riverpod_app/core/model/user_profile.dart';

class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final LoginResponse? loginResponse;
  final UserProfile? userProfile;
  final String? errorMessage;
  final String? token;

  LoginState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.loginResponse,
    this.userProfile,
    this.errorMessage,
    this.token,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    LoginResponse? loginResponse,
    UserProfile? userProfile,
    String? errorMessage,
    String? token,
    bool clearError = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      loginResponse: loginResponse ?? this.loginResponse,
      userProfile: userProfile ?? this.userProfile,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      token: token ?? this.token,
    );
  }
}
