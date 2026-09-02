import 'package:get/get.dart';

import '../../features/authentication/controller/login_controller.dart';
import '../../features/employee_home/controller/employee_home_controller.dart';
import '../../features/employee_home/controller/upcoming_appointment_details_controller.dart';
import '../../features/employee_nav/employee_nav_controller.dart';
import '../../features/employee_profile/controller/edit_profile_controller.dart';
import '../../features/employee_profile/controller/employee_profile_controller.dart';
import '../../features/employee_schedule/controller/scheduled_controller.dart';
import '../../features/messaging/controller/messaging_controller.dart';
import '../../features/splash/controller/splash_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => EmployeeNavController(), fenix: true);
    Get.lazyPut(() => MessagingController(), fenix: true);
    Get.lazyPut(() => EmployeeProfileController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => EmployeeHomeController(), fenix: true);
    Get.lazyPut(() => UpcomingAppointmentDetailsController(), fenix: true);
    Get.lazyPut(() => ScheduledController(), fenix: true);
  }
}
