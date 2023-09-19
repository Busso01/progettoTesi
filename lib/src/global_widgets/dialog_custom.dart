import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';

class DialogCustom {
  static void confirmDrawDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: BorderSide(
        color: AppTheme.colorLilla,
        width: 2.h,
      ),
      width: MediaQuery.of(context).size.width * 0.90,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ).r,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      btnOk: ButtonCustom(
        buttonText: "Conferma",
        height: 40.w,
        paddingHorizontal: 0,
        buttonColor: AppTheme.colorSuccess,
        onPressed: () {
          Get.back();
        },
      ),
      btnCancel: ButtonCustom(
        buttonText: "Cancella",
        height: 40.w,
        paddingHorizontal: 0,
        buttonColor: AppTheme.colorDanger,
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
      btnCancelColor: AppTheme.colorDanger,
      btnCancelText: 'Elimina',
      btnOkColor: AppTheme.colorSuccess,
      btnOkText: 'Completa',
      enableEnterKey: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0).w,
            child: Text(
              textAlign: TextAlign.center,
              'ciao',
              style: TextStyle(
                color: AppTheme.colorTextBlack,
                fontFamily: 'Aeonik',
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 24.sp,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Docente: ",
                      style: AppTheme.normalContentTextStyle,
                    ),
                    TextSpan(
                      text: "ciao",
                      style: AppTheme.normalContentTextStyleBold,
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 24.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Giorno: ",
                          style: AppTheme.normalContentTextStyle,
                        ),
                        TextSpan(
                          text: 'ciao',
                          style: AppTheme.normalContentTextStyleBold,
                        ),
                      ]),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.av_timer_rounded,
                  size: 24.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Orario: ",
                          style: AppTheme.normalContentTextStyle,
                        ),
                        TextSpan(
                          text: 'ciao',
                          style: AppTheme.normalContentTextStyleBold,
                        ),
                      ]),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10).w,
            child: Text(
              "Completa o cancella la ripetizione",
              style: TextStyle(
                color: AppTheme.colorTextBlack,
                fontFamily: 'Aeonik',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  static void historyTimelineAwesomeDialogCompleted(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      borderSide: BorderSide(
        color: AppTheme.colorSuccess,
        width: 2.h,
      ),
      width: MediaQuery.of(context).size.width * 0.90,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ).r,
      padding: const EdgeInsets.all(8).w,
      dialogBorderRadius: BorderRadius.all(const Radius.circular(20).r),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      isDense: true,
      showCloseIcon: true,
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
      title: 'ciao',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0).w,
            child: Text(
              textAlign: TextAlign.center,
              'ciao',
              style: TextStyle(
                color: AppTheme.colorTextBlack,
                fontFamily: 'Aeonik',
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 24.sp,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Docente: ",
                      style: AppTheme.normalContentTextStyle,
                    ),
                    TextSpan(
                      text: "ciao",
                      style: AppTheme.normalContentTextStyleBold,
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 24.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Giorno: ",
                          style: AppTheme.normalContentTextStyle,
                        ),
                        TextSpan(
                          text: 'ciao',
                          style: AppTheme.normalContentTextStyleBold,
                        ),
                      ]),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.av_timer_rounded,
                  size: 24.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Orario: ",
                          style: AppTheme.normalContentTextStyle,
                        ),
                        TextSpan(
                          text: 'ciao',
                          style: AppTheme.normalContentTextStyleBold,
                        ),
                      ]),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10).w,
            child: Text(
              "Prenotazione Completata",
              style: TextStyle(
                color: AppTheme.colorTextBlack,
                fontFamily: 'Aeonik',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ).show();
  }
}
