import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:image/image.dart' as img;

class DrawPageController extends GetxController {
  List<ScribbleNotifier> scribbleNotifier = [
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier()
  ];

  List<GlobalKey> globalKeys = [
    GlobalKey(debugLabel: '1'),
    GlobalKey(debugLabel: '2'),
    GlobalKey(debugLabel: '3'),
    GlobalKey(debugLabel: '4'),
  ];

  ScreenshotController screenshotController = ScreenshotController();
  PageController pageController = PageController(viewportFraction: 0.8);

  List<List<Offset>> drawPoints = [];

  Uint8List? widget;
  Uint8List? draw;
  img.Image? drawImage;
  img.Image? widgetImage;
  List<PointerEvent> pointerDataInfo = [];
  List<Offset> pointerOffset = [];
  var isDrawSaved = false.obs;
  var isWidgetSaved = false.obs;
  var isExpanded = false.obs;
  late String selectedLetter;

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

  Future<void> saveDraw(int index) async {
    var image = await scribbleNotifier[index].renderImage(pixelRatio: 1);
    draw = image.buffer.asUint8List();
    isDrawSaved.value = true;
  }

  void openDetailPage() {
    if (!isExpanded.value) {
      isExpanded.value = true;
    } else {
      isExpanded.value = false;
      clearScribble();
    }
  }

  void clearScribble() {
    scribbleNotifier[0].clear();
    scribbleNotifier[1].clear();
    scribbleNotifier[2].clear();
    scribbleNotifier[3].clear();
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
    } else {
      return 1.1.sp;
    }
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

    print('draw: $numBlackPixelDrawImage');
    print('widget: $numBlackPixelWidgetImage');
    print('match: $numPixelMatching');

    if (numBlackPixelDrawImage >= numBlackPixelWidgetImage * 0.50) {
      if (numPixelMatching >= numBlackPixelWidgetImage * 0.45) {
        return true;
      }
    }

    return false;
  }

  // void checkStyle() {
  //   bool isCorrect = false;
  //   if (drawPoints.length != 2) {
  //     print(isCorrect);
  //   } else {
  //     for (List<Offset> l in drawPoints) {
  //       if (l.first.dx < l.last.dx) {
  //         isCorrect = true;
  //       } else {
  //         isCorrect = false;
  //       }
  //     }
  //   }
  //   print(isCorrect);
  // }
}
