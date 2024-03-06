import 'package:get/get.dart';
import 'package:progettotesi/src/HomePage/home_view_controller.dart';

class HomeViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewController());
  }
}
