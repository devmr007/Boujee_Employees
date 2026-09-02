import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  // Colors & Styling
  final Color backgroundColor;
  final Color? disabledBackgroundColor;
  final AppFont font;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? disabledTextColor;

  // Layout & Sizing
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;

  // States
  final bool isLoading;
  final bool isEnabled;
  final Color? loadingIndicatorColor;

  // Icons & Spacing
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double spacing;

  // Advanced Visuals
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  // Micro-interactions
  final double pressedScale;
  final bool enableHaptics;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor = AppColors.primary,
    this.disabledBackgroundColor,
    this.font = AppFont.inter,
    this.textStyle,
    this.textColor,
    this.disabledTextColor,
    this.width,
    this.height = 50.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.isLoading = false,
    this.isEnabled = true,
    this.loadingIndicatorColor = Colors.white,
    this.prefixWidget,
    this.suffixWidget,
    this.spacing = 8.0,
    this.border,
    this.boxShadow,
    this.gradient,
    this.pressedScale = 0.96,
    this.enableHaptics = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  /// Determines if the button can respond to taps
  bool get _isInteractive =>
      widget.isEnabled && !widget.isLoading && widget.onTap != null;

  /// Resolves the current background color based on state
  Color get _effectiveBackgroundColor {
    if (!_isInteractive && !widget.isLoading) {
      return widget.disabledBackgroundColor ??
          AppColors.grey.withValues(alpha: 0.3);
    }
    if (widget.isLoading) {
      return widget.backgroundColor.withValues(alpha: 0.7);
    }
    return widget.backgroundColor;
  }

  /// Resolves the current text color based on state
  Color get _effectiveTextColor {
    if (!_isInteractive && !widget.isLoading) {
      return widget.disabledTextColor ?? AppColors.grey;
    }
    return widget.textColor ?? widget.textStyle?.color ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: (_isPressed && _isInteractive) ? widget.pressedScale : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _isInteractive ? widget.onTap : null,
        onTapDown: (_) {
          if (_isInteractive) {
            if (widget.enableHaptics) {
              HapticFeedback.lightImpact();
            }
            setState(() => _isPressed = true);
          }
        },
        onTapUp: (_) {
          if (_isPressed) setState(() => _isPressed = false);
        },
        onTapCancel: () {
          if (_isPressed) setState(() => _isPressed = false);
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            border: widget.border,
            color: widget.gradient == null ? _effectiveBackgroundColor : null,
            gradient: _isInteractive ? widget.gradient : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isInteractive ? widget.boxShadow : null,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: widget.height * 0.45,
                    height: widget.height * 0.45,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.loadingIndicatorColor ?? Colors.white,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: widget.mainAxisAlignment,
                    children: [
                      if (widget.prefixWidget != null) ...[
                        widget.prefixWidget!,
                        SizedBox(width: widget.spacing),
                      ],
                      Flexible(
                        child: CustomText(
                          widget.text,
                          font: widget.font,
                          fontSize: widget.textStyle?.fontSize ?? 16,
                          fontWeight:
                              widget.textStyle?.fontWeight ?? FontWeight.bold,
                          color: _effectiveTextColor,
                          letterSpacing: widget.textStyle?.letterSpacing,
                          height: widget.textStyle?.height,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.suffixWidget != null) ...[
                        SizedBox(width: widget.spacing),
                        widget.suffixWidget!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
