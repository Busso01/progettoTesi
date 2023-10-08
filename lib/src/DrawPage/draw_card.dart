import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';
import 'package:progettotesi/src/global_widgets/dialog_custom.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';
import 'package:scribble/scribble.dart';

class DrawCard extends GetView<DrawPageController> {
  final int index;

  const DrawCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var height = 390.h;
    var width = 185.w;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: controller.isExpanded.value ? 10.h : 90.h,
          width: controller.isExpanded.value ? width * 1.2 : width,
          height: controller.isExpanded.value ? height * 1.1 : height,
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
                  width: 160.w,
                  onPressed: () async {
                    await controller.saveDraw(index).then((drawNotEmpty) {
                      if (drawNotEmpty) {
                        return controller.saveLetter(letter()).then((_) =>
                            DialogCustom.confirmDrawDialog(context, index));
                      } else {
                        snackbarCustomDanger('Sezione disegno vuota',
                            'La sezione di disegno non può essere vuota, \n disegna la lettera poi conferma');
                      }
                    });
                    //controller.checkStyle();
                  },
                  paddingHorizontal: 0,
                  fontSize: 12.sp,
                  marginBottom: 15.h,
                  shadowColor: Colors.black,
                  elevation: 2.sp,
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: 90.h,
          child: GestureDetector(
            onTap: controller.openDetailPage,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                //border: controller.isAlreadyDone(index) == 2 ? Border.all(color: AppTheme.colorSuccess, width: 2.w) : controller.isAlreadyDone(index) == 1 ? ,
                border: Border.all(
                    color: controller.drawAlreadyDone(index) == 2
                        ? AppTheme.colorSuccess
                        : Colors.transparent,
                    width: 2.w),
                color: const Color.fromARGB(255, 207, 207, 207),
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    controller.selectTitle(index),
                    style: AppTheme.normalContentTextStyleBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Flexible(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        child: controller.isExpanded.value
                            ? openedDrawCard()
                            : closedDrawCard()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget closedDrawCard() => Column(
        children: [
          letter(),
        ],
      );

  Widget openedDrawCard() => Column(
        key: const Key('expanded'),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              letter(),
              drawSection(),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: 20.sp,
                  onPressed: () {
                    controller.scribbleNotifier[index].clear();
                  },
                  icon: SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: Image.asset('assets/images/rubber.png'),
                  )),
            ],
          ),
        ],
      );

  Widget drawSection() {
    controller.scribbleNotifier[index]
        .setStrokeWidth(controller.selectStrokeWidth(index));
    controller.scribbleNotifier[index]
        .setAllowedPointersMode(ScribblePointerMode.all);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
          width: 90.w,
          height: 140.h,
          decoration: BoxDecoration(
            color: controller.isExpanded.value
                ? const Color.fromARGB(255, 207, 207, 207).withOpacity(0.6)
                : null,
            border: Border.all(width: 1.sp),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Listener(
            onPointerMove: (event) {
              controller.drawPoints.last.add(event.position);
            },
            onPointerDown: ((event) {
              controller.drawPoints.add([]);
            }),
            child: Scribble(
              notifier: controller.scribbleNotifier[index],
            ),
          )),
    );
  }

  Widget letter() => Container(
        width: 90.w,
        height: 140.h,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 207, 207, 207)),
        child: Center(
          child: index == 0
              ? Text(
                  controller.selectedLetter,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontFamily: 'Aeonik'),
                )
              : index == 1
                  ? Text(
                      controller.selectedLetter.toLowerCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                          fontFamily: 'Aeonik'),
                    )
                  : index == 2
                      ? Text(
                          controller.selectedLetter,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40.sp,
                              fontFamily: 'Handlee'),
                        )
                      : Text(
                          controller.selectedLetter.toLowerCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40.sp,
                              fontFamily: 'Handlee'),
                        ),
        ),
      );
}
