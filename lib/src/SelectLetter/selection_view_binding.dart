import 'package:get/get.dart';
import 'package:progettotesi/src/SelectLetter/selection_view_controller.dart';

class SelectionViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SelectionViewController());
  }
}