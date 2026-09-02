import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/employee_home_controller.dart';

class UpcomingAppointmentWidget extends StatelessWidget {
  UpcomingAppointmentWidget({super.key});

  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final appointment = controller.upcomingAppointment.value;

      if (appointment == null) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          // Golden brown gradient background matching the screenshot
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5E0A), Color(0xFF634103)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row: Label & Top Action Buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Next Appointment',
                        fontSize: 13.sp,
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        appointment.serviceTitle,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        '${appointment.petName} · ${appointment.clientName} · ${appointment.serviceCategory}',
                        fontSize: 11.sp,
                        color: AppColors.white.withValues(alpha: 0.7),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Action Buttons (Details & Navigate)
                Column(
                  children: [
                    _buildActionButton('Details', controller.onViewDetailsTap),
                    SizedBox(height: 6.h),
                    _buildActionButton('Navigate', controller.onNavigateTap),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Bottom Highlight Card: Price, Time & ETA
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    '\$${appointment.price.toInt()} · ${appointment.time} · ${appointment.duration}',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9E5442), // Reddish-pink ETA badge
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomText(
                      'ETA ${appointment.eta}',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFC0BD),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper method for the rounded semi-transparent action buttons
  Widget _buildActionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: CustomText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }
}
