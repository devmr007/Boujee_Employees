import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/constants/app_colors.dart';
import '../utils/icon_path/icon_path.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomPopupDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String? iconPath; // Optional: Defaults to Shield Done
  final bool showImage; // Optional: Displays top illustration by default
  final bool
  isDoubleButton; // Optional: Single button (default) or double button

  // Primary Button Properties
  final String primaryButtonText;
  final VoidCallback? onPrimaryTap;

  // Secondary Button Properties (Used if isDoubleButton is true)
  final String secondaryButtonText;
  final VoidCallback? onSecondaryTap;

  const CustomPopupDialog({
    super.key,
    required this.title,
    this.description,
    this.iconPath,
    this.showImage = true,
    this.isDoubleButton = false,
    this.primaryButtonText = "OK",
    this.onPrimaryTap,
    this.secondaryButtonText = "Cancel",
    this.onSecondaryTap,
  });

  /// Static helper method to easily trigger the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    String? iconPath,
    bool showImage = true,
    bool isDoubleButton = false,
    String primaryButtonText = "OK",
    VoidCallback? onPrimaryTap,
    String secondaryButtonText = "Cancel",
    VoidCallback? onSecondaryTap,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      CustomPopupDialog(
        title: title,
        description: description,
        iconPath: iconPath,
        showImage: showImage,
        isDoubleButton: isDoubleButton,
        primaryButtonText: primaryButtonText,
        onPrimaryTap: onPrimaryTap,
        secondaryButtonText: secondaryButtonText,
        onSecondaryTap: onSecondaryTap,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String activeCenterIcon = iconPath ?? IconPath.shieldDone;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Stacked Icon Area (Rendered only if showImage is true)
            if (showImage) ...[
              SizedBox(
                height: 140.h,
                width: 140.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Group Dots Background
                    SvgPicture.asset(
                      IconPath.groupDots,
                      width: 140.w,
                      height: 140.h,
                      fit: BoxFit.contain,
                    ),

                    // Shield Center Icon Container
                    Container(
                      width: 80.r,
                      height: 80.r,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(20.r),
                      child: SvgPicture.asset(
                        activeCenterIcon,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],

            // 2. Title Text (Amber color when image is hidden, Black when image is visible)
            CustomText(
              title,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: showImage ? AppColors.black : AppColors.primary,
              textAlign: TextAlign.center,
              height: 1.3,
            ),

            // 3. Optional Description Text
            if (description != null && description!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              CustomText(
                description!,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                textAlign: TextAlign.center,
                height: 1.4,
              ),
            ],

            SizedBox(height: 24.h),

            // 4. Action Buttons
            if (isDoubleButton)
              Row(
                children: [
                  // Secondary Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onSecondaryTap ?? () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                        side: BorderSide(
                          color: const Color(0xFFE5E7EB),
                          width: 1.5.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: CustomText(
                        secondaryButtonText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Primary Button
                  Expanded(
                    child: CustomButton(
                      text: primaryButtonText,
                      onTap: onPrimaryTap ?? () => Get.back(),
                      backgroundColor: AppColors.primary,
                      borderRadius: 24.r,
                      height: 48.h,
                    ),
                  ),
                ],
              )
            else
              // Single Primary Button
              CustomButton(
                text: primaryButtonText,
                onTap: onPrimaryTap ?? () => Get.back(),
                backgroundColor: AppColors.primary,
                borderRadius: 24.r,
                height: 48.h,
                width: double.infinity,
              ),
          ],
        ),
      ),
    );
  }
}
