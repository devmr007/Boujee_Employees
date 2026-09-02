import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/upcoming_appointment_details_controller.dart';
import '../../model/appointment_details_model.dart';

class AppointmentStatusScreen extends StatelessWidget {
  const AppointmentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingAppointmentDetailsController controller =
        Get.find<UpcomingAppointmentDetailsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          final details = controller.appointmentDetails.value;

          if (details == null) return const SizedBox.shrink();

          return Column(
            children: [
              // Header Section with Back Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.black,
                            size: 16.r,
                          ),
                        ),
                      ),
                    ),
                    CustomText(
                      '${details.petName} - Status',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      // Top Golden Banner Status Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC78330),
                          // Golden brown theme color
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Column(
                          children: [
                            // Shield Icon with Check
                            Container(
                              width: 64.r,
                              height: 64.r,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 38.r,
                                  height: 38.r,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4CAF50), // Green shield
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: AppColors.white,
                                    size: 24.r,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),

                            CustomText(
                              details.currentStatus,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                            SizedBox(height: 4.h),

                            CustomText(
                              details.statusDescription,
                              fontSize: 12.sp,
                              color: AppColors.white.withValues(alpha: 0.9),
                            ),
                            SizedBox(height: 16.h),

                            // Progress Bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: LinearProgressIndicator(
                                value: details.currentStep / details.totalSteps,
                                backgroundColor: AppColors.white.withValues(
                                  alpha: 0.3,
                                ),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                                minHeight: 6.h,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            CustomText(
                              'Step ${details.currentStep} of ${details.totalSteps}',
                              fontSize: 11.sp,
                              color: AppColors.white.withValues(alpha: 0.9),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Timeline Progress Steps List
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'PROGRESS',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(height: 16.h),

                            // Steps List
                            ...List.generate(details.progressSteps.length, (
                              index,
                            ) {
                              final step = details.progressSteps[index];
                              final isLast =
                                  index == details.progressSteps.length - 1;
                              return _buildTimelineStep(step, isLast);
                            }),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              // Bottom Action Buttons Fixed Footer
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Advance Status Outlined Button
                    if (details.nextStepTitle != null) ...[
                      GestureDetector(
                        onTap: () => controller.advanceToNextStep(),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: const Color(0xFFC78330),
                              width: 1.5.w,
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              'Advance to: ${details.nextStepTitle}',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFC78330),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],

                    // Service Checklist & Cancel Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.onServiceChecklistTap(),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC78330), // Gold Button
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: CustomText(
                                  'Service Checklist',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.onCancelTap(),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF2A00), // Red Button
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: CustomText(
                                  'Cancel',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Single Timeline Row Builder
  Widget _buildTimelineStep(ProgressStepModel step, bool isLast) {
    final bool isCompleted = step.isCompleted;
    final bool isCurrent = step.isCurrent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Step Icon Circle/Box
            if (isCompleted || isCurrent)
              Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50), // Green check box
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.white,
                  size: 16.r,
                ),
              )
            else
              Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.5.w),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),

            // Vertical Connecting Line
            if (!isLast)
              Container(
                width: 2.w,
                height: 26.h,
                color: isCompleted
                    ? const Color(0xFF4CAF50)
                    : Colors.grey.shade200,
              ),
          ],
        ),
        SizedBox(width: 12.w),

        // Step Titles & Subtitles
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                step.title,
                fontSize: 14.sp,
                fontWeight: isCurrent || isCompleted
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: isCurrent
                    ? const Color(0xFF2563EB) // Highlight active step blue
                    : (isCompleted
                          ? const Color(0xFF4CAF50)
                          : Colors.grey.shade500),
              ),
              if (step.subtitle != null) ...[
                SizedBox(height: 2.h),
                CustomText(
                  step.subtitle!,
                  fontSize: 11.sp,
                  color: Colors.grey.shade500,
                ),
              ],
              SizedBox(height: isLast ? 0 : 12.h),
            ],
          ),
        ),
      ],
    );
  }
}
