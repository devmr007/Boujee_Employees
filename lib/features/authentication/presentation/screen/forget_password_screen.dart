import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_back_button.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/login_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                "Reset Password",
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),

              SizedBox(height: 6.h),

              // 3. Subtitle Description
              CustomText(
                "Enter your email, we will send a verification\ncode to your email",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.4,
              ),

              SizedBox(height: 32.h),

              // 4. Email Input Field
              CustomTextField(
                controller: controller.forgetPasswordEmailController,
                hintText: "Enter your email",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.primary,
                  size: 20.r,
                ),
                keyboardType: TextInputType.emailAddress,
                borderRadius: 28.r,
              ),

              const Spacer(),

              // 5. Send Code Button
              CustomButton(
                text: "Send Code",
                onTap: controller.onSendCode,
                backgroundColor: AppColors.primary,
                borderRadius: 28.r,
                height: 52.h,
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
