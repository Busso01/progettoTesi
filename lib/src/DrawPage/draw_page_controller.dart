import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:progettotesi/src/DrawPage/image_comparison_model.dart';
import 'package:external_path/external_path.dart';

class DrawPageController extends GetxController {
  List<ScribbleNotifier> scribbleNotifier = [
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier()
  ];

  ScreenshotController screenshotController = ScreenshotController();
  PageController pageController = PageController(viewportFraction: 0.8);
  Uint8List? widgetImage;
  Uint8List? drawImage;
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

  void saveLetter(Widget widget) async {
    widgetImage = await screenshotController.captureFromWidget(widget,
        delay: const Duration(seconds: 0),
        targetSize: Size(100.w, 180.h),
        pixelRatio: 1);
    isWidgetSaved.value = true;
  }

  void saveDraw(int index) async {
    var image = await scribbleNotifier[index].renderImage(pixelRatio: 1);
    drawImage = image.buffer.asUint8List();
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

  void compareImages(int index, Widget widget) async {
    saveDraw(index);
    saveLetter(widget);

    final model = ImageComparisonModel();
    await model.loadModel();

    final embedding1 = await model.getEmbedding(drawImage!);
    final embedding2 = await model.getEmbedding(widgetImage!);

    final similarity = cosineSimilarity(embedding1, embedding2);
    print('Similarity Score: $similarity');
  }

  double cosineSimilarity(List<double> image1, List<double> image2) {
    double dotProduct = 0;
    double norm1 = 0;
    double norm2 = 0;

    for (int i = 0; i < image1.length; i++) {
      dotProduct += image1[i] * image2[i];
      norm1 += pow(image1[i], 2);
      norm2 += pow(image2[i], 2);
    }

    double similarity = dotProduct / (sqrt(norm1) * sqrt(norm2));
    return similarity;
  }
}
