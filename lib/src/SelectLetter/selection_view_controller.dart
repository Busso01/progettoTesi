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
    bool allDone = true;
    bool atLeastOne = false;

    if (savedData[index] != null) {
      for (bool element in savedData[index]!.results) {
        if (element == true) {
          atLeastOne = true;
        } else {
          allDone = false;
        }
      }
      if (allDone) {
        return 2;
      } else if (atLeastOne) {
        return 1;
      } else {
        return 0;
      }
    }
    return 0;
  }
}
