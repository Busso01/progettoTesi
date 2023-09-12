import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:scribble/scribble.dart';
import 'package:signature/signature.dart';
import '../../core/theme/theme.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DrawPageView extends GetView<DrawPageController> {
  const DrawPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color(0xFF545D68),
            size: 30.sp,
          ),
          onPressed: () {
            controller.signatureController.clear();
            controller.notifier.clear();
            Get.back();
          },
        ),
        title: Text(
          'Scrivi la lettera',
          style: AppTheme.submainContentTextStyleBlack,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            letter(),
            drawSection(),
          ],
        ),
      ),
    );
  }

  Widget selectionTile(String letter) {
    return Padding(
        padding:
            EdgeInsets.only(top: 15.h, bottom: 25.h, left: 5.w, right: 5.w),
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2.r),
                    spreadRadius: 3.0.r,
                    blurRadius: 5.0.r),
              ],
              color: Colors.white,
            ),
            child: Center(
                child: Text(
              letter,
              style: TextStyle(fontFamily: 'Handlee', fontSize: 30.sp),
            )),
          ),
        ));
  }

  Widget drawSection() {
    controller.notifier.setStrokeWidth(1.sp);
    controller.notifier.setAllowedPointersMode(ScribblePointerMode.penOnly);
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      child: Scribble(
        notifier: controller.notifier,
        drawPen: true,
      ),
    );
    // return Signature(
    //   controller: controller.signatureController,
    //   width: 140,
    //   height: 140,
    //   backgroundColor: Colors.white.withOpacity(0.5),
    //   dynamicPressureSupported: false,
    // );
    // return Center(
    //   child: SizedBox(
    //     height: 140,
    //     width: 140,
    //     child: SfSignaturePad(
    //       minimumStrokeWidth: 1.sp,
    //       maximumStrokeWidth: 3.sp,
    //       strokeColor: Colors.black,
    //       backgroundColor: Colors.white.withOpacity(0.5),
    //     ),
    //   ),
    // );
  }

  Widget letter() => Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Text(
            controller.selectedLetter,
            style: TextStyle(
                color: Colors.black, fontSize: 46.sp, fontFamily: 'Dancing'),
          ),
        ),
      );
}

Widget buildImage(Uint8List bytes) {
  return Image.memory(bytes);
}
