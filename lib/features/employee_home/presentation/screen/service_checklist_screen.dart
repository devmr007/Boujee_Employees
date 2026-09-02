import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/upcoming_appointment_details_controller.dart';

class ServiceChecklistScreen extends StatelessWidget {
  const ServiceChecklistScreen({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                      'Service Checklist',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),

              // Scrollable Main Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),

                      // Top Progress Card Banner
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    '${details.petName} — ${details.serviceTitle}',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                CustomText(
                                  '${details.completedChecklistCount}/${details.totalChecklistCount}',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFC78330), // Gold text
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),

                            // Gold Linear Progress Bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: LinearProgressIndicator(
                                value: details.checklistProgressRatio,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFFC78330),
                                ),
                                minHeight: 6.h,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            CustomText(
                              '${details.checklistPercentage}% complete',
                              fontSize: 11.sp,
                              color: Colors.grey.shade500,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Grooming Section Label
                      CustomText(
                        'GROOMING',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 8.h),

                      // Checklist Items Container
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: details.checklistItems.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey.shade100,
                            ),
                            itemBuilder: (context, index) {
                              final item = details.checklistItems[index];
                              return ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 2.h,
                                ),
                                leading: GestureDetector(
                                  onTap: () =>
                                      controller.toggleChecklistItem(item.id),
                                  child: Container(
                                    width: 24.r,
                                    height: 24.r,
                                    decoration: BoxDecoration(
                                      color: item.isDone
                                          ? const Color(0xFFC78330)
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                        color: item.isDone
                                            ? const Color(0xFFC78330)
                                            : Colors.grey.shade300,
                                        width: 1.w,
                                      ),
                                    ),
                                    child: item.isDone
                                        ? Icon(
                                            Icons.check_rounded,
                                            color: AppColors.white,
                                            size: 16.r,
                                          )
                                        : null,
                                  ),
                                ),
                                title: CustomText(
                                  item.title,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                onTap: () =>
                                    controller.toggleChecklistItem(item.id),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Completion Notes Section Label
                      CustomText(
                        'COMPLETION NOTES',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 8.h),

                      // Multiline Text Field
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.notesController,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'How did the session go for ${details.petName}?',
                            hintStyle: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Fixed Bottom Action Footer Buttons
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
                    // Upload Photo Outlined Button
                    GestureDetector(
                      onTap: () => controller.onUploadPhotoTap(),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
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
                            'Upload Photo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC78330),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Complete Job Solid Button
                    GestureDetector(
                      onTap: () => controller.onCompleteJobTap(),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC78330), // Solid Gold
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: CustomText(
                            'Complete Job',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
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
}
