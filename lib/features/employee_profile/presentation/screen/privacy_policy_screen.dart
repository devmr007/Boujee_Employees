import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../core/global/custom_back_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with Custom Back Button & Centered Title
              Row(
                children: [
                  const CustomBackButton(),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        'Privacy Policy',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w), // Balances the CustomBackButton
                ],
              ),

              SizedBox(height: 24.h),

              // 2. Privacy Policy Section
              CustomText(
                'Privacy Policy',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),

              SizedBox(height: 12.h),

              CustomText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.5,
              ),

              SizedBox(height: 12.h),

              CustomText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.5,
              ),

              SizedBox(height: 24.h),

              // 3. Terms & Condition Section
              CustomText(
                'Terms & Condition',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),

              SizedBox(height: 12.h),

              CustomText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.5,
              ),

              SizedBox(height: 12.h),

              CustomText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.5,
              ),

              SizedBox(height: 12.h),

              CustomText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.5,
              ),

              SizedBox(height: 12.h),

              CustomText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.5,
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
