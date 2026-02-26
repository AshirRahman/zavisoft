import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';
import 'package:riverpod_app/core/constants/text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isEnabled;
  final EdgeInsets? padding;
  final Border? border;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.padding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      padding: padding,
      decoration: BoxDecoration(
        color: isEnabled
            ? (backgroundColor ?? AppColors.primary)
            : AppColors.textSecondary.withAlpha(51),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        border: border,
      ),
      child: MaterialButton(
        onPressed: isLoading || !isEnabled ? null : onPressed,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            if (isLoading)
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.background,
                  ),
                  strokeWidth: 2,
                ),
              )
            else
              Text(
                text,
                style: getTextStyle(
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  lineHeight: (fontSize ?? 16) * 1.5,
                  color: textColor ?? AppColors.background,
                ),
              ),
            if (suffixIcon != null && !isLoading) ...[
              const SizedBox(width: 8),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
