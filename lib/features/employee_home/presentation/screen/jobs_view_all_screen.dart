import 'package:boujee_employees/core/global/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/employee_home_controller.dart';
import '../widget/job_tile.dart';

class JobsViewAllScreen extends StatelessWidget {
  JobsViewAllScreen({super.key});

  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Top Navigation Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Custom Circular Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),

                  // Header Title
                  CustomText(
                    "Today's Jobs",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),

            SizedBox(height: 8.h),

            // Jobs List View Section
            Expanded(
              child: Obx(() {
                final jobs = controller.jobsList;

                if (jobs.isEmpty) {
                  return Center(
                    child: CustomText(
                      'No jobs available',
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return JobTile(
                      job: job,
                      onTap: () => controller.onJobTap(job),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
