import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/upcoming_appointment_details_controller.dart';

class UploadPhotoScreen extends StatelessWidget {
  const UploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingAppointmentDetailsController controller =
        Get.find<UpcomingAppointmentDetailsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Circular Back Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.black,
                          size: 16.r,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    'Photo Upload',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),

                    // Before Photo Section
                    CustomText(
                      'Before Photo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => _buildUploadCard(
                        title: 'Upload Profile image',
                        subtitle: 'Supports: JPG, PNG',
                        imagePath: controller.beforePhotoPath.value,
                        onPickTap: () => controller.pickBeforePhoto(),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // After Photo Section
                    CustomText(
                      'After Photo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => _buildUploadCard(
                        title: 'Upload business license',
                        subtitle: 'Supports: JPG, PNG, PDF',
                        imagePath: controller.afterPhotoPath.value,
                        onPickTap: () => controller.pickAfterPhoto(),
                      ),
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Save Button Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: Offset(0, -4.h),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => controller.onSavePhotosTap(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC78330), // Gold Theme Color
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: CustomText(
                      'Save',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Upload Card Containers
  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    required String? imagePath,
    required VoidCallback onPickTap,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
      ),
      child: Column(
        children: [
          if (imagePath != null && imagePath.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(
                File(imagePath),
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.h),
          ] else ...[
            // Upload Icon Graphic
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 40.r,
              color: AppColors.black,
            ),
            SizedBox(height: 8.h),
            CustomText(
              title,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            SizedBox(height: 4.h),
            CustomText(
              subtitle,
              fontSize: 11.sp,
              color: const Color(0xFF64748B),
            ),
            SizedBox(height: 14.h),
          ],

          // Yellow "Choose Picture" Button
          GestureDetector(
            onTap: onPickTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFACC15), // Yellow Accent Color
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: CustomText(
                  imagePath != null ? 'Change Picture' : 'Choose Picture',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
