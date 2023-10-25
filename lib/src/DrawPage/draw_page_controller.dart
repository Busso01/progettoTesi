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
import 'package:shared_preferences/shared_preferences.dart';

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

  var isExpanded = false.obs;

  late String selectedLetter;
  late int selectedLetterIndex;
  late SavedData savedDataSingleSet;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < scribbleNotifier.length; i++) {
      setScribbleNotifierSettings(i);
    }
  }

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
        delay: const Duration(seconds: 0));
    widgetImage = img.decodeImage(widget!);
    widget = null;
  }

  Future<void> saveDrawWidget(Widget widgetPassed) async {
    draw = await screenshotController.captureFromWidget(widgetPassed,
        delay: const Duration(seconds: 0));
    drawImage = img.decodeImage(draw!);
    draw = null;
  }

  Future<bool> saveDraw(int index) async {
    Sketch sketch = scribbleNotifier[index].currentSketch;
    if (sketch.lines.isNotEmpty) {
      var image = await scribbleNotifier[index].renderImage();
      draw = image.buffer.asUint8List();
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

  int checkSavedData(int index) {
    bool result = savedDataSingleSet.compareResults[index];
    bool trajectories = savedDataSingleSet.trajectories[index];
    if (result && trajectories) {
      return 1;
    } else if (result) {
      return 2;
    } else if (trajectories) {
      return 3;
    } else {
      return 0;
    }
  }

  bool checkResult(int letterIndex) {
    if (!isExpanded.value) {
      if (checkSavedData(letterIndex) == 1) {
        return true;
      }
    }
    return false;
  }

  void setScribbleNotifierSettings(int index) async {
    try {
      await SharedPreferences.getInstance().then((value) {
        bool? penOnly = value.getBool('penOnly');
        if (penOnly != null) {
          if (!penOnly) {
            scribbleNotifier[index]
                .setAllowedPointersMode(ScribblePointerMode.all);
          } else {
            scribbleNotifier[index]
                .setAllowedPointersMode(ScribblePointerMode.penOnly);
          }
        } else {
          scribbleNotifier[index]
              .setAllowedPointersMode(ScribblePointerMode.penOnly);
        }
      });
      if (index == 0 || index == 1) {
        scribbleNotifier[index].setStrokeWidth(1.25.sp);
      } else if (index == 3) {
        scribbleNotifier[index].setStrokeWidth(1.0.sp);
      } else {
        scribbleNotifier[index].setStrokeWidth(1.05.sp);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool compareImage() {
    int numBlackPixelDraw = 0;
    int numBlackPixelWidget = 0;
    int numPixelMatching = 0;
    for (int y = 0; y < drawImage!.height; y++) {
      for (int x = 0; x < drawImage!.width; x++) {
        final pixelDraw = drawImage!.getPixel(x, y);
        final pixelWidget = widgetImage!.getPixel(x, y);

        if (img.isBlack(pixelWidget)) {
          numBlackPixelWidget++;
        }

        if (img.isBlack(pixelDraw)) {
          numBlackPixelDraw++;
        }

        if ((img.isBlack(pixelDraw) && img.isBlack(pixelWidget))) {
          numPixelMatching++;
        }
      }
    }

    if (numBlackPixelDraw >= numBlackPixelWidget * 0.45 &&
        numBlackPixelDraw <= numBlackPixelWidget * 1.2) {
      if (numPixelMatching >= numBlackPixelWidget * 0.40) {
        return true;
      }
    }
    return false;
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

          if (dtw > 3) {
            return false;
          }
        }
        return true;
      }
    } catch (e) {
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

  Future<bool> saveResult(bool result, int index, bool trajectories) async {
    savedDataSingleSet.compareResults[index] = result;
    savedDataSingleSet.trajectories[index] = trajectories;
    savedDataSingleSet.letterDraw[index] =
        jsonEncode(scribbleNotifier[index].currentSketch);

    return ApiService()
        .saveResultAPI(savedDataSingleSet)
        .then((value) => value);
  }

  Future<Sketch?> loadSketchFromJson(int index) async {
    String jsonString = await rootBundle.loadString('assets/path.json');
    Map<String, dynamic> mapFromJson = jsonDecode(jsonString);
    SavedLetterPath savedLetterPath = SavedLetterPath.fromJson(mapFromJson);
    LettersPath lettersPath =
        LettersPath.fromJson(savedLetterPath.letterPath[selectedLetter]);

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
