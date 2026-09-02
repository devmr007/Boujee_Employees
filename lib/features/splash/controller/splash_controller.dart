import 'dart:async';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // 3-second splash timer
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to Onboarding 1
    Get.offAllNamed(AppRoutes.login);
  }
}
