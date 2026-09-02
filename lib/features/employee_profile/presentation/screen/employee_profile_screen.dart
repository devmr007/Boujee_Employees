import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/icon_path/icon_path.dart';
import '../../controller/employee_profile_controller.dart';

class EmployeeProfileScreen extends StatelessWidget {
  EmployeeProfileScreen({super.key});

  final EmployeeProfileController controller =
      Get.find<EmployeeProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final data = controller.profileData.value;
          if (data == null) {
            return const Center(child: Text("No profile data found"));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              children: [
                // Title
                Center(
                  child: CustomText(
                    'Profile',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 20.h),

                // User Avatar
                CircleAvatar(
                  radius: 42.r,
                  backgroundColor: const Color(0xFFE5ECEF),
                  backgroundImage: NetworkImage(data.avatarUrl),
                  onBackgroundImageError: (_, _) {},
                ),
                SizedBox(height: 12.h),

                // Name & Email
                CustomText(
                  'Hi, ${data.name}',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  data.email,
                  fontSize: 13.sp,
                  color: AppColors.bodyTextColor,
                ),
                SizedBox(height: 6.h),

                // Badge / Rating / Jobs Done
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      data.badge,
                      fontSize: 12.sp,
                      color: AppColors.bodyTextColor,
                    ),
                    CustomText(
                      ' • ',
                      fontSize: 12.sp,
                      color: AppColors.bodyTextColor,
                    ),
                    Icon(Icons.star_rounded, color: Colors.amber, size: 16.r),
                    CustomText(
                      ' ${data.rating} ',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    CustomText(
                      '• ',
                      fontSize: 12.sp,
                      color: AppColors.bodyTextColor,
                    ),
                    CustomText(
                      '${data.jobsDone} Jobs Done',
                      fontSize: 12.sp,
                      color: AppColors.bodyTextColor,
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFE5E7EB), thickness: 1),
                SizedBox(height: 16.h),

                // Employee Info Section
                _buildCardContainer(
                  title: 'EMPLOYEE INFO',
                  child: Column(
                    children: [
                      _buildInfoRow('Role', data.role, isBold: true),
                      const Divider(color: Color(0xFFF3F4F6), height: 20),
                      _buildInfoRow(
                        'Employee ID',
                        data.employeeId,
                        isBold: true,
                      ),
                      const Divider(color: Color(0xFFF3F4F6), height: 20),
                      _buildInfoRow('Start Date', data.startDate, isBold: true),
                      const Divider(color: Color(0xFFF3F4F6), height: 20),
                      _buildInfoRow(
                        'Experience',
                        data.experience,
                        isBold: true,
                      ),
                      const Divider(color: Color(0xFFF3F4F6), height: 20),
                      _buildInfoRow(
                        'Working Hours',
                        data.workingHours,
                        isBold: true,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Certifications Section
                _buildCardContainer(
                  title: 'CERTIFICATIONS',
                  child: Column(
                    children: data.certifications
                        .map(
                          (cert) => Row(
                            children: [
                              Text(
                                cert.icon,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: CustomText(
                                  cert.title,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),

                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFE5E7EB), thickness: 1),
                SizedBox(height: 8.h),

                // Navigation / Action Buttons
                _buildMenuItem(
                  iconPath: IconPath.profile,
                  title: 'Edit profile',
                  onTap: controller.onEditProfileTap,
                ),
                _buildMenuItem(
                  iconPath: IconPath.certificate,
                  title: 'Certifications',
                  onTap: controller.onCertificationsTap,
                ),
                _buildMenuItem(
                  iconPath: IconPath.privacyPolicy,
                  title: 'Privacy Policy',
                  onTap: controller.onPrivacyPolicyTap,
                ),
                _buildMenuItem(
                  iconPath: IconPath.deleteAccount,
                  title: 'Delete Account',
                  textColor: Colors.redAccent,
                  iconColor: Colors.redAccent,
                  onTap: controller.onDeleteAccountTap,
                ),
                _buildMenuItem(
                  iconPath: IconPath.logout,
                  title: 'Logout',
                  textColor: Colors.redAccent,
                  iconColor: Colors.redAccent,
                  onTap: controller.onLogoutTap,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCardContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF9CA3AF),
            letterSpacing: 0.5,
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label, fontSize: 13.sp, color: AppColors.bodyTextColor),
        CustomText(
          value,
          fontSize: 13.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: AppColors.black,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color textColor = AppColors.black,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22.r,
              height: 22.r,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                  : null,
            ),
            SizedBox(width: 14.w),
            CustomText(
              title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
