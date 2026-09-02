import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/upcoming_appointment_details_controller.dart';

class CompleteAppointmentScreen extends StatelessWidget {
  const CompleteAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingAppointmentDetailsController controller =
        Get.find<UpcomingAppointmentDetailsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Obx(() {
                  final details = controller.appointmentDetails.value;
                  final petName = details?.petName ?? 'Truffle';
                  final clientName = details?.clientName ?? 'Sarah Mitchell';

                  return Column(
                    children: [
                      SizedBox(height: 60.h),

                      // Shield Celebration Icon with Yellow Dots Graphic
                      SizedBox(
                        width: 160.r,
                        height: 160.r,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Decorative Outer Yellow Dots
                            Positioned(
                              top: 25.h,
                              left: 20.w,
                              child: _buildDot(16.r, const Color(0xFFFFC107)),
                            ),
                            Positioned(
                              top: 30.h,
                              right: 25.w,
                              child: _buildDot(12.r, const Color(0xFFFFC107)),
                            ),
                            Positioned(
                              bottom: 35.h,
                              left: 15.w,
                              child: _buildDot(10.r, const Color(0xFFFFC107)),
                            ),
                            Positioned(
                              bottom: 25.h,
                              right: 20.w,
                              child: _buildDot(8.r, const Color(0xFFFFC107)),
                            ),
                            Positioned(
                              top: 10.h,
                              child: _buildDot(6.r, const Color(0xFFFFC107)),
                            ),

                            // Main Gold Circle
                            Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC78330), // Gold theme color
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                // Shield Container
                                child: Container(
                                  width: 44.r,
                                  height: 48.r,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: const Color(0xFFC78330),
                                    size: 28.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Title
                      CustomText(
                        'Job Complete!',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      SizedBox(height: 8.h),

                      // Description
                      CustomText(
                        'Great work! $petName is looking boujee. The appointment with $clientName has been logged.',
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 36.h),

                      // 2x2 Details Grid Summary Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              label: 'SERVICE TIME',
                              value: '90 min',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildStatCard(
                              label: 'CUSTOMER',
                              value: details?.clientName ?? 'Robert Cary',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              label: 'EARNINGS',
                              value: '\$100',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildStatCard(
                              label: 'RATING',
                              value: '5.0',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),
                    ],
                  );
                }),
              ),
            ),

            // Fixed Bottom Action Footer Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: Offset(0, -4.h),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => controller.onBackToHomeTap(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC78330), // Solid Gold
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: CustomText(
                      'Back to Home',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Grid Stat Cards
  Widget _buildStatCard({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
      ),
      child: Column(
        children: [
          CustomText(
            label,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF64748B),
          ),
          SizedBox(height: 6.h),
          CustomText(
            value,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Dot Helper
  Widget _buildDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
