import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          hint: CustomText(
            hintText,
            fontSize: 14.sp,
            color: Colors.grey.shade400,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black87,
            size: 24.sp,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: CustomText(
                item,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
