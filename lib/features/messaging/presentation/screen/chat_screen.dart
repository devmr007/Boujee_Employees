import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/global/custom_back_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/messaging_controller.dart';
import '../widget/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final MessagingController controller = Get.find<MessagingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header with Avatar & User Name
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  const CustomBackButton(),
                  SizedBox(width: 12.w),

                  // Avatar
                  Obx(() {
                    final avatar =
                        controller.activeConversation.value?.userAvatar ?? '';
                    return Container(
                      width: 42.r,
                      height: 42.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE5ECEF),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          avatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            color: Colors.grey.shade400,
                            size: 24.r,
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(width: 12.w),

                  // User Name Title
                  Expanded(
                    child: Obx(
                      () => CustomText(
                        controller.activeConversation.value?.userName ?? 'Chat',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: const Color(0xFFF3F4F6), height: 1.h),

            // 2. Chat Messages Stream
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  itemCount: controller.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = controller.chatMessages[index];
                    return ChatBubble(message: message);
                  },
                ),
              ),
            ),

            // 3. Message Input Field & Send Action
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.messageInputController,
                      hintText: 'Type a message...',
                      borderRadius: 28.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
