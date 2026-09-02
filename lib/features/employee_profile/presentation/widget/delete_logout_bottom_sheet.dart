import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/global/custom_button.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';

class DeleteLogoutBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const DeleteLogoutBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmButtonText,
    this.cancelButtonText = "Cancel",
    required this.onConfirm,
    this.onCancel,
  });

  /// Helper to trigger the Delete variant
  static Future<T?> showDelete<T>({
    required VoidCallback onDeleteConfirm,
    VoidCallback? onCancel,
  }) {
    return Get.bottomSheet<T>(
      DeleteLogoutBottomSheet(
        title: "Delete",
        subtitle: "Are you sure you want to delete?",
        confirmButtonText: "Yes, Delete",
        onConfirm: onDeleteConfirm,
        onCancel: onCancel,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Helper to trigger the Logout variant
  static Future<T?> showLogout<T>({
    required VoidCallback onLogoutConfirm,
    VoidCallback? onCancel,
  }) {
    return Get.bottomSheet<T>(
      DeleteLogoutBottomSheet(
        title: "Logout",
        subtitle: "Are you sure you want to log out?",
        confirmButtonText: "Yes, Logout",
        onConfirm: onLogoutConfirm,
        onCancel: onCancel,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header Title
          CustomText(
            title,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // 2. Subtitle Text
          CustomText(
            subtitle,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.bodyTextColor,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 28.h),

          // 3. Action Buttons Row
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: TextButton(
                    onPressed: onCancel ?? () => Get.back(),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(
                        0xFFFFF2EE,
                      ), // Soft tint matching screenshot
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    child: CustomText(
                      cancelButtonText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              // Confirm Action Button (Yes, Delete / Yes, Logout)
              Expanded(
                child: CustomButton(
                  text: confirmButtonText,
                  onTap: onConfirm,
                  backgroundColor: AppColors.primary,
                  borderRadius: 24.r,
                  height: 48.h,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
