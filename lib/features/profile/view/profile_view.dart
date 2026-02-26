import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/core/constants/text_style.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';
import 'package:riverpod_app/core/routes/app_routes.dart';
import 'package:riverpod_app/core/widgets/custom_button.dart';

import '../../auth/login/controller/login_controller.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(loginControllerProvider.select((state) => state.isLoggedIn));
    final userProfile =
        ref.watch(loginControllerProvider.select((state) => state.userProfile));

    if (!isLoggedIn || userProfile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Center(
          child: Text(
            'Please login first',
            style: getTextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final user = userProfile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: 50.r,
                backgroundColor: AppColors.primary,
                child: Text(
                  user.firstName!,
                  style: getTextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // User Info
              Text(
                '${user.firstName} ${user.lastName}',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                user.email,
                style: getTextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),

              // Info Cards
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.divider),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    _buildInfoRow('Username', user.username),
                    Divider(color: AppColors.divider, height: 16.h),
                    _buildInfoRow('ID', user.id.toString()),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Logout Button
              CustomButton(
                text: 'Logout',
                onPressed: () {
                  ref.read(loginControllerProvider.notifier).logout();
                  context.go(AppRoutes.login);
                },
                isLoading: false,
                isEnabled: true,
                height: 56,
                backgroundColor: AppColors.error,
                textColor: AppColors.background,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
