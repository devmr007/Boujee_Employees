import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/messaging_controller.dart';
import '../../model/conversation_model.dart';

class MessagingScreen extends StatelessWidget {
  MessagingScreen({super.key});

  final MessagingController controller = Get.find<MessagingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header with Back Button & Centered Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 20.r,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    'Message',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // 2. Custom Tab Toggle (Customer vs Support Team)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: _buildTabButton(
                          title: 'Customer',
                          isSelected: controller.selectedTabIndex.value == 0,
                          onTap: () => controller.changeTab(0),
                        ),
                      ),
                      Expanded(
                        child: _buildTabButton(
                          title: 'Support Team',
                          isSelected: controller.selectedTabIndex.value == 1,
                          onTap: () => controller.changeTab(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // 3. Search Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                controller: controller.searchController,
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: const Color(0xFF9CA3AF),
                  size: 22.r,
                ),
                borderRadius: 28.r,
              ),
            ),

            SizedBox(height: 16.h),

            // 4. Conversations List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (controller.filteredConversations.isEmpty) {
                  return Center(
                    child: CustomText(
                      'No messages found',
                      fontSize: 14.sp,
                      color: AppColors.bodyTextColor,
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: controller.filteredConversations.length,
                  separatorBuilder: (context, index) => Divider(
                    color: const Color(0xFFF3F4F6),
                    height: 1.h,
                    indent: 20.w,
                    endIndent: 20.w,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.filteredConversations[index];
                    return _buildConversationItem(item);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggle Button Widget
  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: CustomText(
            title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  /// Individual Conversation Tile
  Widget _buildConversationItem(ConversationModel conversation) {
    return InkWell(
      onTap: () => controller.onConversationTap(conversation),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            // User Avatar
            Container(
              width: 52.r,
              height: 52.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE5ECEF),
              ),
              child: ClipOval(
                child: Image.network(
                  conversation.userAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    color: Colors.grey.shade400,
                    size: 30.r,
                  ),
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // User Name & Message Preview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    conversation.userName,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    conversation.lastMessage,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyTextColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Timestamp & Unread Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  conversation.time,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyTextColor,
                ),
                SizedBox(height: 8.h),

                // Unread Count Badge
                if (conversation.unreadCount > 0)
                  Container(
                    width: 22.r,
                    height: 22.r,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CustomText(
                        '${conversation.unreadCount}',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 22.r),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
