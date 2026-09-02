import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_loading.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/icon_path/icon_path.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 3),

            // Logo Image
            Center(
              child: Image.asset(
                IconPath.appLogo,
                width: 160.w,
                height: 160.h,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 16.h),

            // App Title
            CustomText(
              "Boujee Pet Services",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),

            const Spacer(flex: 3),

            // Animated Circular Loading Indicator
            CustomLoading(
              type: LoadingType.circularDots,
              size: 45.r,
              color: AppColors.primary,
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
