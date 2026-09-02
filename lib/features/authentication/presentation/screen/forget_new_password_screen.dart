import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_back_button.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/login_controller.dart';

class ForgetNewPasswordScreen extends StatelessWidget {
  ForgetNewPasswordScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Back Button
              const CustomBackButton(),

              SizedBox(height: 24.h),

              // 2. Title Header
              CustomText(
                "Create New Password",
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),

              SizedBox(height: 6.h),

              // 3. Subtitle Description
              CustomText(
                "Your password must be different\nfrom previous used password",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.4,
              ),

              SizedBox(height: 32.h),

              // 4. New Password Input
              CustomTextField(
                controller: controller.newPasswordController,
                hintText: "Password",
                isPassword: true,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: const Color(0xFF9CA3AF),
                  size: 20.r,
                ),
                borderRadius: 28.r,
              ),

              SizedBox(height: 16.h),

              // 5. Confirm Password Input
              CustomTextField(
                controller: controller.confirmNewPasswordController,
                hintText: "Confirm password",
                isPassword: true,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: const Color(0xFF9CA3AF),
                  size: 20.r,
                ),
                borderRadius: 28.r,
              ),

              SizedBox(height: 32.h),

              // 6. Reset Password Button
              CustomButton(
                text: "Reset Password",
                onTap: () => controller.onResetPassword(context),
                backgroundColor: AppColors.primary,
                borderRadius: 28.r,
                height: 52.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
