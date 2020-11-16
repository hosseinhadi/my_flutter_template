import 'package:flutter_app6/app/bindings/binding.dart';
import 'package:flutter_app6/app/ui/android/pages/home/home_page.dart';
import 'package:get/get.dart';
export 'app_pages.dart';
// import 'package:getx_pattern/app/bindings/details_binding.dart';
// import 'package:getx_pattern/app/bindings/expendedWidget_binding.dart';
// import 'package:getx_pattern/app/ui/android/details/details_page.dart';
// import 'package:getx_pattern/app/ui/android/expandedWidget/expendedWidget_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //     name: Routes.DETAILS,
    //     page: () => DetailsPage(),
    //     binding: DetailsBinding()),
    // GetPage(
    //     name: Routes.EXPENDEDWIDGET,
    //     page: () => ExpendedWidgetPage(),
    //     binding: ExpendedWidgetBinding())
  ];
  // static final pagesNames = ['Expended Widget'];
}
