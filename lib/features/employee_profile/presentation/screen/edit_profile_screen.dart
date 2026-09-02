import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_back_button.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_drop_down.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Bar Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  CustomText(
                    'Edit Profile',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),

            // 2. Form Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with Edit Button
                    Center(
                      child: Stack(
                        children: [
                          Obx(() {
                            final imagePath = controller.imagePath.value;
                            return Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE5ECEF),
                              ),
                              child: ClipOval(
                                child: imagePath.isNotEmpty
                                    ? Image.file(
                                        File(imagePath),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        controller.avatarUrl.value,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                                  Icons.person,
                                                  size: 50.r,
                                                  color: Colors.grey,
                                                ),
                                      ),
                              ),
                            );
                          }),
                          Positioned(
                            bottom: 2.h,
                            right: 2.w,
                            child: GestureDetector(
                              onTap: controller.pickProfileImage,
                              child: Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 14.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Full Name
                    _buildFieldLabel('Full Name'),
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: 'Enter full name',
                      borderRadius: 28.r,
                    ),

                    SizedBox(height: 16.h),

                    // Email
                    _buildFieldLabel('Email'),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Enter email',
                      keyboardType: TextInputType.emailAddress,
                      borderRadius: 28.r,
                    ),

                    SizedBox(height: 16.h),

                    // Phone
                    _buildFieldLabel('Phone'),
                    CustomTextField(
                      controller: controller.phoneController,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                      borderRadius: 28.r,
                    ),

                    SizedBox(height: 16.h),

                    // Role Dropdown
                    _buildFieldLabel('Role'),
                    Obx(
                      () => CustomDropdownField(
                        value: controller.selectedRole.value,
                        items: controller.roles,
                        hintText: 'Select role',
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedRole.value = value;
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Gender Dropdown
                    _buildFieldLabel('Gender'),
                    Obx(
                      () => CustomDropdownField(
                        value: controller.selectedGender.value,
                        items: controller.genders,
                        hintText: 'Select gender',
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedGender.value = value;
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Address
                    _buildFieldLabel('Address'),
                    CustomTextField(
                      controller: controller.addressController,
                      hintText: 'Enter address',
                      borderRadius: 28.r,
                    ),

                    SizedBox(height: 32.h),

                    // Custom Save Button
                    Obx(
                      () => CustomButton(
                        text: 'Save',
                        onTap: controller.saveProfile,
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

  /// Field Label Header Widget
  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        label,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }
}
