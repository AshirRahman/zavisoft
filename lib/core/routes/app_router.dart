// riverpod/lib/core/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod/core/bootstrap/dependency_injection.dart';
// Import for sessionManagerProvider
// Import your actual screens
import 'package:riverpod_app/core/routes/app_routes.dart';
// import 'package:riverpod_app/features/auth/splash/screen/splash_screen.dart';
import 'package:riverpod_app/features/home/view/home_view.dart';
import 'package:riverpod_app/features/auth/login/view/login_view.dart';
import 'package:riverpod_app/features/auth/login/controller/login_controller.dart';
import 'package:riverpod_app/features/profile/view/profile_view.dart';
// // Note: You may need to create a dummy HomeScreen if you haven't yet, or use SampleListScreen
// import 'package:riverpod/features/sample_crud/screens/sample_list_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // Watch only isLoggedIn to avoid router rebuild on every state change
  final isLoggedIn =
      ref.watch(loginControllerProvider.select((state) => state.isLoggedIn));

  return GoRouter(
    initialLocation: AppRoutes.login,
    // Redirect Logic (Guard) - Handle auth navigation
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == AppRoutes.login;

      // If not logged in and not on login page, go to login
      if (!isLoggedIn && !isGoingToLogin) {
        return AppRoutes.login;
      }

      // If logged in and on login page, go to home
      if (isLoggedIn && isGoingToLogin) {
        return AppRoutes.home;
      }

      return null; // No redirect needed
    },
    //   final isLoggedIn = session.isLoggedIn;
    //   final isLoggingIn = state.matchedLocation == AppRoutes.login ||
    //       state.matchedLocation == AppRoutes.signup;
    //   final isSplash = state.matchedLocation == AppRoutes.splash;

    //   // Allow splash to finish its job (Splash screen usually handles its own navigation,
    //   // but strictly speaking, if we are on splash, we might want to wait.
    //   // For this logic, we rely on the Splash screen to push to /login or /home,
    //   // OR we can let this redirect handler do it immediately.)

    //   // Strict Guard:
    //   if (!isLoggedIn && !isLoggingIn && !isSplash) {
    //     return AppRoutes.login;
    //   }

    //   if (isLoggedIn && isLoggingIn) {
    //     return AppRoutes.home;
    //   }

    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeView(),
      ),

      // Login Route
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),

      // Profile Route
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileView(),
      ),
    ],
  );
});
