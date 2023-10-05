import 'package:get/get.dart';
import 'package:progettotesi/core/models/saved_data.dart';

class SelectionViewController extends GetxController {
  List<SavedData?> savedData = [];

  @override
  void onInit() {
    savedData = Get.arguments;
    super.onInit();
  }

  List<bool>? getLetterCardInfo(int letterIndex) {
    if (savedData[letterIndex] != null) {
      return savedData[letterIndex]?.results;
    } else {
      return null;
    }
  }

  int checkSavedDatas(int index) {
    if (savedData[index] != null) {
      if (savedData[index]!.results.any((element) => element == false)) {
        return 1;
      } else {
        return 2;
      }
    } else {
      return 0;
    }
  }
}
