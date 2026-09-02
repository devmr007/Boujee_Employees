import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/employee_home_controller.dart';
import '../widget/employee_header.dart';
import '../widget/employee_stats_summary.dart';
import '../widget/job_tile.dart';
import '../widget/upcoming_appoinment.dart';

class EmployeeHome extends StatelessWidget {
  EmployeeHome({super.key});

  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              EmployeeHeader(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Stats Summary Card & Clock In/Out Button
                    EmployeeStatsSummaryWidget(),

                    SizedBox(height: 24.h),

                    // Upcoming Appointment Section Title
                    CustomText(
                      'Upcoming appointment',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 12.h),

                    // Upcoming Appointment Widget Card
                    UpcomingAppointmentWidget(),

                    SizedBox(height: 24.h),

                    // Today's Jobs Header & View All Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "Today's Jobs",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        GestureDetector(
                          onTap: controller.onViewAllJobsTap,
                          child: CustomText(
                            'View All',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(
                              0xFFC78330,
                            ), // Golden brown accent
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Today's Jobs List (Limited to maximum of 3)
                    Obx(() {
                      // Limits display to 3 jobs for the home page
                      final displayJobs = controller.jobsList.take(3).toList();

                      if (displayJobs.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: CustomText(
                              'No jobs assigned for today',
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: displayJobs.map((job) {
                          return JobTile(
                            job: job,
                            onTap: () => controller.onJobTap(job),
                          );
                        }).toList(),
                      );
                    }),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
