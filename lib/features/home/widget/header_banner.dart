import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/core/model/user_profile.dart';
import 'package:riverpod_app/core/widgets/custom_text_field.dart';
import 'package:riverpod_app/core/constants/text_style.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';
import 'package:riverpod_app/core/routes/app_routes.dart';

class HeaderBanner extends StatefulWidget {
  final UserProfile? user;
  const HeaderBanner({super.key, this.user});

  @override
  State<HeaderBanner> createState() => _HeaderBannerState();
}

class _HeaderBannerState extends State<HeaderBanner> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Greeting + Profile Avatar
          Row(
            children: [
              GestureDetector(
                onTap: () => context.push(AppRoutes.profile),
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundColor: AppColors.background,
                  child: Text(
                    widget.user?.firstName?.isNotEmpty == true
                        ? widget.user!.firstName![0].toUpperCase()
                        : 'S',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Hello, ${widget.user?.firstName ?? 'Shopper'}',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    lineHeight: 30,
                    color: AppColors.background,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: _searchController,
            hintText: 'Search products',
            prefixIcon: const Icon(Icons.search, color: Color(0xFF757575)),
            borderRadius: 8,
            fillColor: AppColors.background,
            borderColor: AppColors.background,
            focusedBorderColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
