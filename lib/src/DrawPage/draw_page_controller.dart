import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:signature/signature.dart';
import 'package:image_compare/image_compare.dart';

class DrawPageController extends GetxController {
  ScribbleNotifier notifier = ScribbleNotifier();
  Uint8List? widgetImage;
  var isWidgetSaved = false.obs;
  Uint8List? drawImage;
  var isDrawSaved = false.obs;
  SignatureController signatureController = SignatureController(
    penStrokeWidth: 3.sp,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
  );
  ScreenshotController screenshotController = ScreenshotController();
  late String selectedLetter;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onClose() {
    notifier.dispose();
    animationController.dispose();
    signatureController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // selectedLetter = Get.arguments;
    super.onInit();
  }

  void takeScreenShot(Widget widget) async {
    widgetImage = await screenshotController.captureFromWidget(widget,
        delay: const Duration(seconds: 0), targetSize: const Size(150, 150));
    isWidgetSaved.value = true;
    print('Widget image taken');
  }

  void saveDraw() async {
    drawImage = await signatureController.toPngBytes(height: 150, width: 150);
    isDrawSaved.value = true;
    print('Draw image taken');
    compare();
  }

  void compare() async {
    var result = await compareImages(
        src1: drawImage,
        src2: widgetImage,
        algorithm: PixelMatching(ignoreAlpha: true, tolerance: 0.05));
    print('differences $result');
  }
}
