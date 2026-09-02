import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../model/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 12.h,
          left: message.isMe ? 60.w : 0,
          right: message.isMe ? 0 : 60.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: message.isMe ? Radius.circular(20.r) : Radius.zero,
            bottomRight: message.isMe ? Radius.zero : Radius.circular(20.r),
          ),
          boxShadow: [
            if (!message.isMe)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              message.message,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: message.isMe ? AppColors.white : AppColors.black,
              height: 1.4,
            ),
            SizedBox(height: 4.h),
            CustomText(
              message.time,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: message.isMe
                  ? AppColors.white.withValues(alpha: 0.7)
                  : AppColors.bodyTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
