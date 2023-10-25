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
    var width = 195.w;
    int dataSavedValue = controller.checkSavedData(index);

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
                        controller.saveLetter(letter()).then((_) =>
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
        Positioned(
          bottom: 90.h,
          child: GestureDetector(
            onTap: () {
              controller.checkResult(index)
                  ? DialogCustom.drawAlreadyDoneDialog(context)
                  : controller.openDetailPage();
            },
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                //border: controller.isAlreadyDone(index) == 2 ? Border.all(color: AppTheme.colorSuccess, width: 2.w) : controller.isAlreadyDone(index) == 1 ? ,
                border: Border.all(
                    color: controller.isExpanded.value
                        ? Colors.transparent
                        : (dataSavedValue == 1
                            ? AppTheme.colorSuccess
                            : dataSavedValue == 2 || dataSavedValue == 3
                                ? AppTheme.colorWarning
                                : Colors.transparent),
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
                    height: 25.h,
                  ),
                  Flexible(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        child: controller.isExpanded.value
                            ? openedDrawCard()
                            : closedDrawCard(dataSavedValue)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget closedDrawCard(int dataSavedValue) => Column(
        children: [
          letter(),
          SizedBox(
            height: 10.h,
          ),
          dataSavedValue == 1
              ? allCompletedWithSuccess()
              : dataSavedValue == 2
                  ? onlyAccuracyCompleted()
                  : dataSavedValue == 3
                      ? onlyPathCompleted()
                      : allCompletedWithFail()
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
    controller.setScribbleNotifierSettings(index);
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
          child: Scribble(
            notifier: controller.scribbleNotifier[index],
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
                              fontFamily: 'Dancing'),
                        )
                      : Text(
                          controller.selectedLetter.toLowerCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40.sp,
                              fontFamily: 'Dancing'),
                        ),
        ),
      );

  Widget allCompletedWithSuccess() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorSuccess),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_rounded,
                color: AppTheme.colorSuccess,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Accuratezza',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorSuccess),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_rounded,
                color: AppTheme.colorSuccess,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Metodologia',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget allCompletedWithFail() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorDanger),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close_rounded,
                color: AppTheme.colorDanger,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Accuratezza',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorDanger),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close_rounded,
                color: AppTheme.colorDanger,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Metodologia',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onlyAccuracyCompleted() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorSuccess),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_rounded,
                color: AppTheme.colorSuccess,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Accuratezza',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorDanger),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close_rounded,
                color: AppTheme.colorDanger,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Metodologia',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onlyPathCompleted() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorDanger),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close_rounded,
                color: AppTheme.colorDanger,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Accuratezza',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1.sp, color: AppTheme.colorSuccess),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_rounded,
                color: AppTheme.colorSuccess,
                size: 28.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Metodologia',
                style: AppTheme.normalContentTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
