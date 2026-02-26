import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_app/core/widgets/custom_text_field.dart';
import 'package:riverpod_app/core/widgets/custom_button.dart';
import 'package:riverpod_app/core/constants/text_style.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';

import '../controller/login_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(loginControllerProvider.select((state) => state.isLoading));
    final errorMessage = ref
        .watch(loginControllerProvider.select((state) => state.errorMessage));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Icon(Icons.storefront, size: 64.sp, color: AppColors.primary),
                SizedBox(height: 24.h),
                Text(
                  'ZaviMart Login',
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    lineHeight: 36,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your username and password',
                  style: getTextStyle(
                    fontSize: 14,
                    lineHeight: 21,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Demo: test / 12345',
                    style: getTextStyle(
                      fontSize: 12,
                      lineHeight: 18,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                if (errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withAlpha(26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      errorMessage,
                      style: getTextStyle(
                        fontSize: 14,
                        lineHeight: 21,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  hintText: 'Enter username',
                  prefixIcon: const Icon(Icons.person),
                  borderRadius: 8,
                  readOnly: isLoading,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock),
                  borderRadius: 8,
                  readOnly: isLoading,
                ),
                const SizedBox(height: 28),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    final username = _usernameController.text.trim();
                    final password = _passwordController.text.trim();

                    if (username.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }

                    // Call login - GoRouter will handle navigation via redirect
                    ref.read(loginControllerProvider.notifier).login(
                          username: username,
                          password: password,
                        );
                  },
                  isLoading: isLoading,
                  isEnabled: !isLoading,
                  height: 56,
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.background,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
