import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/employee_home_controller.dart';

class EmployeeStatsSummaryWidget extends StatelessWidget {
  EmployeeStatsSummaryWidget({super.key});

  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top Overview Stats Card
        Obx(() {
          final stats = controller.statsData.value;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: const Color(
                0xFFF6F5E8,
              ), // Subtle cream background from design
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('JOBS', '${stats?.totalJobs ?? 0}'),
                _buildStatItem('COMPLETED', '${stats?.completedJobs ?? 0}'),
                _buildStatItem('HOURS', '${stats?.hoursWorked ?? 0}h'),
                _buildStatItem(
                  'EARNED',
                  '\$${stats?.totalEarned.toInt() ?? 0}',
                ),
              ],
            ),
          );
        }),

        SizedBox(height: 16.h),

        // Clock In / Clock Out Button
        Obx(() {
          final isClockedIn = controller.isClockedIn.value;
          final buttonColor = isClockedIn
              ? const Color(0xFFDFF1D3)
              : const Color(0xFFC78382);
          final textColor = isClockedIn
              ? const Color(0xFF4CAF50)
              : const Color(0xFFE53935);
          final statusText = isClockedIn ? 'Clock In' : 'Clock Out';

          return GestureDetector(
            onTap: () => controller.toggleClockInStatus(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Status Dot Indicator
                  Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: BoxDecoration(
                      color: textColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),

                  // Button Text
                  CustomText(
                    statusText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // Helper method for single stat column
  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          label,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
        SizedBox(height: 6.h),
        CustomText(
          value,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ],
    );
  }
}
