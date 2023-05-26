import 'package:get/get.dart';
import '/admin/dashboard/dashboard_binding.dart';
import '/admin/dashboard/dashboard_page.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
