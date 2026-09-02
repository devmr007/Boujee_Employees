import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants/app_colors.dart';
import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final AppFont font;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;

  // Functionality
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;

  // Length & Lines
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  // Icons & Design Customization
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color fillColor;
  final bool filled;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.errorText,
    this.font = AppFont.inter,
    this.textStyle,
    this.hintStyle,
    this.errorStyle,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor = AppColors.white,
    this.filled = true,
    this.borderRadius = 15.0,
    this.contentPadding,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  TextStyle _getFontWithStyle(AppFont appFont, TextStyle baseStyle) {
    switch (appFont) {
      case AppFont.impact:
        return baseStyle.copyWith(fontFamily: 'Impact');
      case AppFont.roboto:
        return GoogleFonts.roboto(textStyle: baseStyle);
      case AppFont.poppins:
        return GoogleFonts.poppins(textStyle: baseStyle);
      case AppFont.inter:
        return GoogleFonts.inter(textStyle: baseStyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTextStyle =
        widget.textStyle ??
        const TextStyle(fontSize: 14, color: Colors.black87);

    final Color defaultBorderColor = AppColors.primary.withValues(alpha: 0.15);
    final Color focusBorderColor = AppColors.primary;

    // Build default password toggle icon if isPassword is true and no custom suffixIcon is passed
    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.isPassword && widget.suffixIcon == null) {
      effectiveSuffixIcon = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey[600],
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      // Pass null for maxLines if password obscuring is enabled (Flutter requirement)
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      style: _getFontWithStyle(widget.font, resolvedTextStyle),
      decoration: InputDecoration(
        filled: widget.filled,
        fillColor: widget.enabled
            ? widget.fillColor
            : AppColors.grey.withValues(alpha: 0.1),
        errorText: widget.errorText,
        errorStyle: widget.errorStyle,
        label: widget.labelText != null
            ? CustomText(
                widget.labelText!,
                font: widget.font,
                color: Colors.grey[600],
                fontSize: 14,
              )
            : null,
        hintText: widget.hintText,
        hintStyle: _getFontWithStyle(
          widget.font,
          widget.hintStyle ??
              TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: effectiveSuffixIcon,
        contentPadding:
            widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: defaultBorderColor, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: defaultBorderColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: focusBorderColor, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: AppColors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.red, width: 1.5),
        ),
      ),
    );
  }
}
