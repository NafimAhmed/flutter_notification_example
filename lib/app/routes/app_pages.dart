import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notification_page/bindings/notification_page_binding.dart';
import '../modules/notification_page/views/notification_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PAGE,
      page: () => const NotificationPageView(),
      binding: NotificationPageBinding(),
    ),
  ];
}
