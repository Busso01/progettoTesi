import 'package:get/get.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';

class SelectionViewController extends GetxController {
  List<SavedData?> savedData = [];

  @override
  void onInit() {
    savedData = Get.arguments;
    super.onInit();
  }

  int checkSavedDatas(int index) {
    bool allDone = true;
    bool atLeastOne = false;

    if (savedData[index] != null) {
      for (bool element in savedData[index]!.compareResults) {
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

  void initializeDrawPageController(int index) {
    DrawPageController drawPageController = Get.put(DrawPageController());
    drawPageController.selectedLetter = String.fromCharCode(index + 65);
    drawPageController.selectedLetterIndex = index;

    if (savedData[index] != null) {
      drawPageController.savedDataSingleSet = savedData[index]!;
    } else {
      List<bool> defaultTrajectoriesValues = List.generate(4, (index) => false);
      List<bool> defaultCompareValues = List.generate(4, (index) => false);
      List<String> emptyDraw = List.generate(4, (index) => "");
      SavedData defaultData = SavedData(
          trajectories: defaultTrajectoriesValues,
          letterIndex: index,
          compareResults: defaultCompareValues,
          letterDraw: emptyDraw);
      drawPageController.savedDataSingleSet = defaultData;
    }
  }
}
