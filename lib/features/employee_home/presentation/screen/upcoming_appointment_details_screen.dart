import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/upcoming_appointment_details_controller.dart';
import '../../../../routes/app_routes.dart';

class UpcomingAppointmentDetailsScreen extends StatelessWidget {
  UpcomingAppointmentDetailsScreen({super.key});

  final UpcomingAppointmentDetailsController controller =
      Get.find<UpcomingAppointmentDetailsController>();

  void _openStatusBottomSheet() {
    Get.toNamed(AppRoutes.appointmentStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          final details = controller.appointmentDetails.value;

          if (details == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Column(
                children: [
                  // Header Title Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'ROUTE OVERVIEW',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          '${details.startAddress} - ${details.destinationAddress}',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Google Map View Container
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            onMapCreated: controller.onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: details.startLocation,
                              zoom: 14.0,
                            ),
                            markers: controller.markers,
                            polylines: controller.polylines,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                          ),

                          // Map Zoom Controls (+ / -)
                          Positioned(
                            right: 16.w,
                            bottom: 100.h,
                            child: Column(
                              children: [
                                _buildZoomButton(Icons.add, controller.zoomIn),
                                SizedBox(height: 8.h),
                                _buildZoomButton(
                                  Icons.remove,
                                  controller.zoomOut,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 120.h,
                  ), // Space reserved for floating bottom card
                ],
              ),

              // Bottom Destination Card Overlay (Tap to open Status Sheet)
              Positioned(
                left: 16.w,
                right: 16.w,
                bottom: 16.h,
                child: GestureDetector(
                  onTap: _openStatusBottomSheet,
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.06),
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Destination',
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFFFEBF0,
                                ), // Light pink background
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: CustomText(
                                'ETA ${details.eta}',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE53935), // Red text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          details.petName,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            CustomText(
                              '${details.clientName} · ',
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                            Icon(
                              Icons.location_on_rounded,
                              size: 14.r,
                              color: const Color(0xFFE53935),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: CustomText(
                                details.destinationAddress,
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          '${details.clientName} · ${details.serviceTitle}',
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Zoom Button Widget Helper
  Widget _buildZoomButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.black, size: 20.r),
      ),
    );
  }
}
