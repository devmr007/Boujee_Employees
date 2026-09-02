import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/edit_profile_controller.dart';

class CertificateScreen extends StatelessWidget {
  CertificateScreen({super.key});

  final EditProfileController controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Navigation Bar Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 20.r,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    'Certifications',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),

            // 2. Main Content Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // List of Uploaded Certificates
                    Obx(() {
                      if (controller.certificates.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.certificates.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final path = controller.certificates[index];
                              return _buildCertificateCard(path, index);
                            },
                          ),
                          SizedBox(height: 20.h),
                          _buildDashedLine(),
                          SizedBox(height: 20.h),
                        ],
                      );
                    }),

                    // Add Certificate Section Header
                    CustomText(
                      'Add Certificate',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 12.h),

                    // Upload Picker Card Box
                    _buildUploadBox(),

                    SizedBox(height: 36.h),

                    // Save Button
                    Obx(
                      () => CustomButton(
                        text: 'Save',
                        onTap: controller.saveCertificates,
                        isLoading: controller.isLoading.value,
                        borderRadius: 28.r,
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Single Certificate Preview Card with Delete Button
  Widget _buildCertificateCard(String imagePath, int index) {
    final bool isNetwork = imagePath.startsWith('http');

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEF),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFFEF3C7)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: isNetwork
                ? Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image)),
                  )
                : Image.file(File(imagePath), fit: BoxFit.cover),
          ),
        ),

        // Floating Red Delete Button
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: GestureDetector(
            onTap: () => controller.removeCertificate(index),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                color: Color(0xFFFF2A2A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: Colors.white,
                size: 18.r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Upload Card Box
  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          // Upload Icon
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 48.r,
            color: AppColors.black,
          ),
          SizedBox(height: 12.h),

          // Header Text
          CustomText(
            'Upload Profile image',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 6.h),

          // Subtitle Text
          CustomText(
            'Supports: JPG, PNG',
            fontSize: 12.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 16.h),

          // Choose Picture Button
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: controller.pickCertificateImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: CustomText(
                'Choose Picture',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Light Horizontal Line Separator
  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            (constraints.constrainWidth() / 10).floor(),
            (_) => SizedBox(
              width: 5.w,
              height: 1.h,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFD1D5DB)),
              ),
            ),
          ),
        );
      },
    );
  }
}
