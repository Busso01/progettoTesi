import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progettotesi/core/jsonLetterModel/letters_path.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/core/jsonLetterModel/saved_letters_path.dart';
import 'package:progettotesi/core/services/api_service.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;

class DrawPageController extends GetxController {
  List<ScribbleNotifier> scribbleNotifier = [
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier()
  ];

  ScreenshotController screenshotController = ScreenshotController();
  PageController pageController = PageController(viewportFraction: 0.8);

  List<double> drawPointsX = [];
  List<double> drawPointsY = [];

  Uint8List? widget;
  Uint8List? draw;

  img.Image? drawImage;
  img.Image? widgetImage;

  Map<String, dynamic> paths = {};

  var isDrawSaved = false.obs;
  var isWidgetSaved = false.obs;
  var isExpanded = false.obs;

  late String selectedLetter;
  late int selectedLetterIndex;
  late SavedData? savedData;

  @override
  void onClose() {
    scribbleNotifier[0].dispose();
    scribbleNotifier[1].dispose();
    scribbleNotifier[2].dispose();
    scribbleNotifier[3].dispose();
    pageController.dispose();
    super.onClose();
  }

  Future<void> saveLetter(Widget widgetPassed) async {
    widget = await screenshotController.captureFromWidget(widgetPassed,
        delay: const Duration(seconds: 0), pixelRatio: 1);
    widgetImage = img.decodeImage(widget!);
    isWidgetSaved.value = true;
  }

  Future<void> saveDrawWidget(Widget widgetPassed) async {
    draw = await screenshotController.captureFromWidget(widgetPassed,
        delay: const Duration(seconds: 0), pixelRatio: 1);
    drawImage = img.decodeImage(draw!);
  }

  Future<bool> saveDraw(int index) async {
    if (scribbleNotifier[index].currentSketch.lines.isNotEmpty) {
      try {
        // String pathToJson = letterPathToJson(path);
        // SavedLetterPath savedLetterPath =
        //     SavedLetterPath(letterPath: list.cast());
        // String savedPathJson = savedLetterPathToJson(savedLetterPath);

        // list.clear();
        // list = savedLetterPathFromJson(savedPathJson).letterPath;
        // List<LettersPath> paths =
        //     List<LettersPath>.from(list.map((e) => LettersPath.fromJson(e)));
        // Sketch s = Sketch.fromJson(paths[0].capitalBlockLetter);
      } catch (e) {
        print(e.toString());
      }

      var image = await scribbleNotifier[index].renderImage(pixelRatio: 1);
      draw = image.buffer.asUint8List();
      isDrawSaved.value = true;
      return true;
    }
    return false;
  }

  void openDetailPage() {
    if (!isExpanded.value) {
      isExpanded.value = true;
    } else {
      isExpanded.value = false;
      //clearAllScribbles();
    }
  }

  void clearAllScribbles() {
    scribbleNotifier[0].clear();
    scribbleNotifier[1].clear();
    scribbleNotifier[2].clear();
    scribbleNotifier[3].clear();
  }

  void resetControllerValues() {
    clearAllScribbles();
    isExpanded.value = false;
    isDrawSaved.value = false;
    isWidgetSaved.value = false;
  }

  String selectTitle(int index) {
    switch (index) {
      case 0:
        return 'Stampatello \n maiuscolo';
      case 1:
        return 'Stampatello \n minuscolo';
      case 2:
        return 'Corsivo \n maiuscolo';
      case 3:
        return 'Corsivo \n minuscolo';
    }
    return '';
  }

  double selectStrokeWidth(int index) {
    if (index == 0 || index == 1) {
      return 1.25.sp;
    } else if (index == 3) {
      return 1.0.sp;
    } else {
      return 1.05.sp;
    }
  }

  int drawAlreadyDone(int index) {
    switch (savedData?.compareResults[index]) {
      case true:
        return 2;
      case false:
        return 1;
      case null:
        return 0;
    }
  }

  bool checkResult(int letterIndex) {
    if (!isExpanded.value) {
      if (drawAlreadyDone(letterIndex) == 2) {
        return true;
      }
    }
    return false;
  }

  // void compareImage() async {
  //   var result = calculateMSE(drawImage!, widgetImage!);

  //   // print('drawW: ${drawImage?.width}, drawH: ${drawImage?.height}');
  //   // print('widgetW: ${widgetImage?.width}, widgetH: ${widgetImage?.height}');
  //   print('result: $result');
  // }

  // double calculateMSE(img.Image img1, img.Image img2) {
  //   double mse = 0.0;
  //   for (int y = 0; y < img1.height; y++) {
  //     for (int x = 0; x < img1.width; x++) {
  //       final pixel1 = img1.getPixel(x, y);
  //       final pixel2 = img2.getPixel(x, y);

  //       final redDiff = img.getRed(pixel1) - img.getRed(pixel2);
  //       final greenDiff = img.getGreen(pixel1) - img.getGreen(pixel2);
  //       final blueDiff = img.getBlue(pixel1) - img.getBlue(pixel2);

  //       final pixelMSE =
  //           (redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff) /
  //               3.0;
  //       mse += pixelMSE;
  //     }
  //   }
  //   mse /= (img1.width * img1.height);

  //   return mse;
  // }

  bool compareImage() {
    int numBlackPixelDrawImage = 0;
    int numBlackPixelWidgetImage = 0;
    int numPixelMatching = 0;
    for (int y = 0; y < drawImage!.height; y++) {
      for (int x = 0; x < drawImage!.width; x++) {
        final pixelDrawImage = drawImage!.getPixel(x, y);
        final pixelWidgetImage = widgetImage!.getPixel(x, y);

        if (img.isBlack(pixelWidgetImage)) {
          numBlackPixelWidgetImage++;
        }

        if (img.isBlack(pixelDrawImage)) {
          numBlackPixelDrawImage++;
        }

        if ((img.isBlack(pixelDrawImage) && img.isBlack(pixelWidgetImage))) {
          numPixelMatching++;
        }
      }
    }

    if (numBlackPixelDrawImage >= numBlackPixelWidgetImage * 0.45 &&
        numBlackPixelDrawImage <= numBlackPixelWidgetImage * 1.2) {
      if (numPixelMatching >= numBlackPixelWidgetImage * 0.40) {
        return true;
      }
    }
    return false;
  }

  Future<bool> saveResult(bool result, int index, bool trajectories) async {
    bool success = false;
    if (savedData != null) {
      savedData?.compareResults[index] = result;
      savedData?.trajectories[index] = trajectories;
      success = await ApiService().saveResultAPI(savedData!);
      return success;
    } else {
      List<bool> results = [false, false, false, false];
      List<bool> trajectories = [false, false, false, false];
      results[index] = result;
      savedData = SavedData(
          letterIndex: selectedLetterIndex,
          compareResults: results,
          trajectories: trajectories);
      success = await ApiService().saveResultAPI(savedData!);
      return success;
    }
  }

  Future<bool> checkLetterPath(int index) async {
    double dtw;
    try {
      Sketch? letter = await loadSketchFromJson(index);
      Sketch draw = scribbleNotifier[index].currentSketch;
      if (draw.lines.length != letter!.lines.length) {
        return false;
      } else {
        for (int i = 0; i < letter.lines.length; i++) {
          List<Point> drawLines = draw.lines[i].points;
          List<Point> letterLines = letter.lines[i].points;
          dtw = calculateDTW(drawLines, letterLines);
          print('draw: ${drawLines.length}');
          print('letter: ${letterLines.length}');
          print('dtw: $dtw \n\n');
          if (dtw > 3.25) {
            return false;
          }
        }
        return true;
      }
    } catch (e) {
      print(e.toString());
      snackbarCustomDanger('Errore controllo traiettoria',
          'Si è verificato un errore nella verifica \n della traiettoria, riprovare');
    }
    return false;
  }

  double calculateDTW(List<Point> drawLines, List<Point> letterLines) {
    List<List> dtw = List.generate(drawLines.length,
        (index) => List.generate(letterLines.length, (index) => 0.0));
    double cost;

    for (int i = 0; i < drawLines.length; i++) {
      for (int j = 0; j < letterLines.length; j++) {
        dtw[i][j] = double.infinity;
      }
    }
    dtw[0][0] = 0;
    for (int i = 1; i < drawLines.length; i++) {
      for (int j = 1; j < letterLines.length; j++) {
        cost = sqrt(pow((drawLines[i].x - letterLines[j].x), 2) +
            pow((drawLines[i].y - letterLines[j].y), 2));
        dtw[i][j] =
            cost + min(dtw[i - 1][j], min(dtw[i][j - 1], dtw[i - 1][j - 1]));
      }
    }

    return sqrt(
        dtw[drawLines.length - 1][letterLines.length - 1] / drawLines.length);
  }

  Future<Sketch?> loadSketchFromJson(int index) async {
    String jsonString = await rootBundle.loadString('assets/path.json');
    Map<String, dynamic> mapFromJson = jsonDecode(jsonString);
    SavedLetterPath savedLetterPath = SavedLetterPath.fromJson(mapFromJson);
    LettersPath lettersPath =
        LettersPath.fromJson(savedLetterPath.letterPath['A']);

    switch (index) {
      case 0:
        return Sketch.fromJson(lettersPath.capitalBlockLetter);
      case 1:
        return Sketch.fromJson(lettersPath.lowerCaseBlockLetter);
      case 2:
        return Sketch.fromJson(lettersPath.capitalItalic);
      case 3:
        return Sketch.fromJson(lettersPath.lowerCaseItalic);
      default:
        return null;
    }
  }

  void printJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/path.json');

    LettersPath lettersPath = LettersPath(
        capitalBlockLetter: scribbleNotifier[0].currentSketch.toJson(),
        lowerCaseBlockLetter: scribbleNotifier[1].currentSketch.toJson(),
        capitalItalic: scribbleNotifier[2].currentSketch.toJson(),
        lowerCaseItalic: scribbleNotifier[3].currentSketch.toJson());
    paths[selectedLetter] = lettersPath;

    SavedLetterPath savedLetterPath = SavedLetterPath(letterPath: paths);
    String savedPathJson = jsonEncode(savedLetterPath);

    file.writeAsString(savedPathJson);
  }
}
