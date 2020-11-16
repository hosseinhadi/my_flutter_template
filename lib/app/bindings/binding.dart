import 'package:flutter_app6/app/controllers/home_controller.dart';

// import 'home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () {
        return HomeController();
      },
    );
  }
}
