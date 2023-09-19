import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';
import 'package:progettotesi/src/global_widgets/dialog_custom.dart';
import 'package:scribble/scribble.dart';

class DrawCard extends StatelessWidget {
  final int index;

  const DrawCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    DrawPageController controller = Get.find();

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: controller.isExpanded.value ? 150.h : 236.h,
          width: controller.isExpanded.value ? 175.w * 1.2 : 175.w,
          height: controller.isExpanded.value ? 420.h * 1.1 : 420.h,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 99, 99, 99),
              borderRadius: BorderRadius.all(
                Radius.circular(25.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 129, 126, 126),
                  offset: const Offset(5, 5),
                  blurRadius: 4.r,
                  spreadRadius: 0.r,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCustom(
                  buttonText: 'Conferma',
                  height: 50.h,
                  width: 120.w,
                  onPressed: () {
                    // DialogCustom.confirmDrawDialog(context);
                    controller.saveDraw(index);
                    controller.saveLetter(letter(index, controller));
                  },
                  paddingHorizontal: 0,
                  fontSize: 12.sp,
                  marginBottom: 20.h,
                  shadowColor: Colors.black,
                  elevation: 2.sp,
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: 236.h,
          child: GestureDetector(
            onTap: controller.openDetailPage,
            child: Container(
              height: 420.h,
              width: 175.w,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 207, 207),
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    controller.selectTitle(index),
                    style: AppTheme.normalContentTextStyleBold,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          letter(index, controller),
                          drawSection(controller, index),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget drawSection(DrawPageController controller, int index) {
  controller.scribbleNotifier[index].setStrokeWidth(1.sp);
  controller.scribbleNotifier[index]
      .setAllowedPointersMode(ScribblePointerMode.penOnly);
  return Container(
    width: 100.w,
    height: 180.h,
    decoration: BoxDecoration(
        color: controller.isExpanded.value
            ? const Color.fromARGB(255, 207, 207, 207).withOpacity(0.5)
            : null),
    child: controller.isExpanded.value
        ? Scribble(
            notifier: controller.scribbleNotifier[index],
          )
        : null,
  );
}

Widget letter(int index, DrawPageController controller) => Container(
      width: 100.w,
      height: 180.h,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Center(
        child: index == 0
            ? Text(
                controller.selectedLetter,
                style: TextStyle(
                    color: Colors.black, fontSize: 46.sp, fontFamily: 'Aeonik'),
              )
            : index == 1
                ? Text(
                    controller.selectedLetter.toLowerCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 46.sp,
                        fontFamily: 'Aeonik'),
                  )
                : index == 2
                    ? Text(
                        controller.selectedLetter,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 46.sp,
                            fontFamily: 'Dancing'),
                      )
                    : Text(
                        controller.selectedLetter.toLowerCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 46.sp,
                            fontFamily: 'Dancing'),
                      ),
      ),
    );
