import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/icon_path/icon_path.dart';
import '../../../../routes/app_routes.dart';
import '../../../employee_profile/controller/employee_profile_controller.dart';

class EmployeeHeader extends StatelessWidget {
  EmployeeHeader({super.key});

  final EmployeeProfileController controller =
      Get.find<EmployeeProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final profile = controller.profileData.value;
      final name = profile?.name ?? 'Alex Hope';
      final avatarUrl = profile?.avatarUrl;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(color: Colors.grey.shade50),
        child: Row(
          children: [
            // Avatar with Online Status Indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                      ? NetworkImage(avatarUrl)
                      : null,
                  onBackgroundImageError:
                      avatarUrl != null && avatarUrl.isNotEmpty
                      ? (_, _) {}
                      : null,
                  child: avatarUrl == null || avatarUrl.isEmpty
                      ? Icon(Icons.person, color: Colors.grey, size: 28.r)
                      : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14.r,
                    height: 14.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50), // Online green
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2.w),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),

            // Greeting and User Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    'Hi, $name!',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    'Welcome back',
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),

            // Notification Bell
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.notifications);
              },
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.08),
                      blurRadius: 6.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      IconPath.notificationBell,
                      width: 22.r,
                      height: 22.r,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    Positioned(
                      top: -1.h,
                      right: 0,
                      child: Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50), // Badge green dot
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
