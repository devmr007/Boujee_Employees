import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../core/global/custom_popup_dialog.dart';
import '../../../core/utils/icon_path/icon_path.dart';

class LoginController extends GetxController {
  // Login Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Forgot Password Text Controller
  final forgetPasswordEmailController = TextEditingController();

  // New Password Reset Controllers
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  // Verification / OTP Controllers & State
  final forgetPasswordPinController = TextEditingController();
  final forgetPasswordPinFocusNode = FocusNode();
  final RxInt secondsRemaining = 43.obs;
  Timer? _timer;

  // UI State Observables
  final RxBool isPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmNewPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  // --- Password Visibility Toggles ---
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmNewPasswordVisibility() {
    isConfirmNewPasswordVisible.value = !isConfirmNewPasswordVisible.value;
  }

  // --- Sign In Actions ---
  void onSignIn() {
    Get.toNamed(AppRoutes.employeeNavBar);
  }

  void onGoogleSignIn() {
    // Google Sign-In logic will be implemented here
  }

  // --- Forgot Password Actions ---
  void onSendCode() {
    final email = forgetPasswordEmailController.text.trim();
    if (email.isNotEmpty) {
      startResendTimer();
      Get.toNamed(AppRoutes.forgetPasswordVerification);
    }
  }

  // --- Timer Actions ---
  void startResendTimer() {
    secondsRemaining.value = 43;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  // --- OTP Verification Action ---
  void onVerifyForgetPasswordCode(BuildContext context) {
    final code = forgetPasswordPinController.text.trim();
    if (code.length == 4) {
      Get.toNamed(AppRoutes.resetPassword);
    } else {
      Get.snackbar(
        "Error",
        "Please enter 4 digit code",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // --- Reset Password Action ---
  void onResetPassword(BuildContext context) {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmNewPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in both password fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Show Success Popup Dialog
    CustomPopupDialog.show(
      context: context,
      title: "Password Reset\nSuccessfully",
      description:
          "Password changed successfully, you can login again with new password",
      iconPath: IconPath.shieldDone,
      isDoubleButton: false,
      primaryButtonText: "Done",
      onPrimaryTap: () {
        Get.back(); // Close Dialog
        Get.offAllNamed(AppRoutes.login); // Go back to Login Screen
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
