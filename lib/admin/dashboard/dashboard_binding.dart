import 'package:get/get.dart';
import 'package:owari/admin/admn/admin_controller.dart';
import '/admin/home/home_controller.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AdminController>(() => AdminController());
  }
}
