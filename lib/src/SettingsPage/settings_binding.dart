import 'package:get/get.dart';
import 'package:progettotesi/src/SettingsPage/settings_controller.dart';

class SettingsViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsViewController());
  }
}
