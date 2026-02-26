import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';
import 'package:riverpod_app/core/constants/text_style.dart';

import '../model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                product.image,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 80.w,
                  height: 80.w,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.image, size: 32.sp, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      lineHeight: 20,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      lineHeight: 24,
                      color: AppColors.primary,
                    ),
                  ),
                  if (product.rating != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16.sp, color: AppColors.rating),
                        SizedBox(width: 4.w),
                        Text(
                          '${product.rating}',
                          style: getTextStyle(
                            fontSize: 12,
                            lineHeight: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
