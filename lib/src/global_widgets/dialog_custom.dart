import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progettotesi/core/services/api_service.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';

class DialogCustom {
  static void confirmDrawDialog(BuildContext context, var index) {
    DrawPageController controller = Get.find();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: BorderSide(
        color: AppTheme.colorLilla,
        width: 2.h,
      ),
      width: MediaQuery.of(context).size.width * 0.70,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ).r,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOk: ButtonCustom(
        fontSize: 15.sp,
        buttonText: "Conferma",
        height: 50.h,
        paddingHorizontal: 0,
        buttonColor: AppTheme.colorSuccess,
        onPressed: () {
          Get.back();
          controller.saveDrawWidget(drawnImage()).then((value) async {
            bool result = controller.compareImage();
            await controller.saveResult(result, index).then((value) {
              if (value) {
                result
                    ? DialogCustom.successDialog(context, index)
                    : DialogCustom.failDialog(context, index);
              }
            });
          });
        },
      ),
      btnCancel: ButtonCustom(
        fontSize: 15.sp,
        buttonText: "Riprova",
        height: 50.h,
        paddingHorizontal: 0,
        buttonColor: AppTheme.colorDanger,
        onPressed: () {
          //controller.scribbleNotifier[index].clear();
          //controller.drawPoints.clear();
          Get.back();
        },
      ),
      isDense: true,
      padding: const EdgeInsets.all(8).w,
      dialogBorderRadius: BorderRadius.all(const Radius.circular(20).r),
      enableEnterKey: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            'Vuoi confermare la lettera?',
            style: TextStyle(
              color: AppTheme.colorTextBlack,
              fontFamily: 'Aeonik',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Image.memory(controller.draw!),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              "Conferma per procedere \n con la valutazione",
              style: TextStyle(
                color: AppTheme.colorTextBlack,
                fontFamily: 'Aeonik',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      showCloseIcon: false,
    ).show();
  }

  static void successDialog(BuildContext context, var index) {
    DrawPageController controller = Get.find();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      borderSide: BorderSide(
        color: AppTheme.colorSuccess,
        width: 2.h,
      ),
      width: MediaQuery.of(context).size.width * 0.70,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ).r,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOk: ButtonCustom(
        fontSize: 12.sp,
        buttonText: "Nuova lettera",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: Colors.black,
        onPressed: () async {
          controller.resetControllerValues();
          var savedData = await ApiService().getAllPersistenceData();
          if (savedData != null) {
            Get.offAllNamed('/selectionView', arguments: savedData);
          }
          Get.back();
        },
      ),
      btnCancel: ButtonCustom(
        fontSize: 12.sp,
        buttonText: "Cambia Stile",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: Colors.black,
        onPressed: () {
          controller.resetControllerValues();
          Get.back();
        },
      ),
      isDense: true,
      padding: const EdgeInsets.all(8).w,
      dialogBorderRadius: BorderRadius.all(const Radius.circular(20).r),
      titleTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
      ),
      descTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
      enableEnterKey: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Ottimo!',
      desc: 'Hai scritto la lettera correttamente',
      showCloseIcon: false,
    ).show();
  }

  static void failDialog(BuildContext context, var index) {
    DrawPageController controller = Get.find();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      borderSide: BorderSide(
        color: AppTheme.colorDanger,
        width: 2.h,
      ),
      width: MediaQuery.of(context).size.width * 0.70,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ).r,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOk: Hero(
        tag: 'home',
        child: ButtonCustom(
          fontSize: 12.sp,
          buttonText: "Nuova lettera",
          height: 50.h,
          width: 90.w,
          paddingHorizontal: 0,
          buttonColor: Colors.black,
          onPressed: () async {
            controller.resetControllerValues();
            Get.offAllNamed('/selectionView',
                arguments: await ApiService().getAllPersistenceData());
          },
        ),
      ),
      btnCancel: ButtonCustom(
        fontSize: 12.sp,
        buttonText: "Riprova",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: Colors.black,
        onPressed: () {
          controller.scribbleNotifier[index].clear();
          Get.back();
        },
      ),
      isDense: true,
      padding: const EdgeInsets.all(8).w,
      dialogBorderRadius: BorderRadius.all(const Radius.circular(20).r),
      titleTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      ),
      descTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
      enableEnterKey: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Insufficiente!',
      desc: 'Prova a scrivere meglio la lettera',
      showCloseIcon: true,
    ).show();
  }

  static void drawAlreadyDoneDialog(BuildContext context) {
    DrawPageController controller = Get.find();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: BorderSide(
        color: AppTheme.colorWarning,
        width: 2.h,
      ),
      width: MediaQuery.of(context).size.width * 0.70,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ).r,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOk: Hero(
        tag: 'home',
        child: ButtonCustom(
          fontSize: 12.sp,
          buttonText: "Prosegui",
          height: 50.h,
          width: 90.w,
          paddingHorizontal: 0,
          buttonColor: Colors.black,
          onPressed: () {
            controller.openDetailPage();
            Get.back();
          },
        ),
      ),
      btnCancel: ButtonCustom(
        fontSize: 12.sp,
        buttonText: "Annulla",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: Colors.black,
        onPressed: () {
          Get.back();
        },
      ),
      isDense: true,
      padding: const EdgeInsets.all(8).w,
      dialogBorderRadius: BorderRadius.all(const Radius.circular(20).r),
      titleTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      ),
      descTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
      enableEnterKey: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Lettera già completata',
      desc:
          'Hai già completato la lettera con successo, se confermi di nuovo sovrascriverai i dati',
      showCloseIcon: true,
    ).show();
  }

  static drawnImage() {
    DrawPageController controller = Get.find();
    return Container(
        height: 140.h,
        width: 90.w,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 207, 207, 207)),
        child: Image.memory(controller.draw!));
  }
}
