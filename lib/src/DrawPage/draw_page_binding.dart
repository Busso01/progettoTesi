import 'package:get/instance_manager.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';

class DrawPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DrawPageController());
  }
}
