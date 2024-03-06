import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progettotesi/core/services/api_service.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/SettingsPage/settings_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';

/*
  La classe racchiude tutti i vari dialog utilizzati nell'applicazione
*/
class DialogCustom {
  /* 
    Dialog di conferma, si occupa di richiamare le varie funzioni per effettuare la valutazione della letteta,
    e richiama il secondo dialog corretto in base al risultato ottenuto
  */
  static void confirmDrawDialog(BuildContext context, var letterIndex) {
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
        onPressed: () async {
          Get.back();
          controller.saveDrawWidget(drawnImage()).then(                         // salva l'immagine della lettera ed aspetta che sia completato
            (imageSaved) async {
              bool result = controller.compareImage();                          // confronta le immagini delle lettere
              await controller.checkLetterPath(letterIndex).then(               // effettua il confronto della traiettoria (che verrà saltato se disabilitato)
                    (resultOfComparison) async => await controller              
                        .saveResult(result, letterIndex, resultOfComparison)    // salva i risultati
                        .then(
                      (resultSaved) {
                        if (resultSaved) {
                          if (controller.isTrajectoryCheckingOnValue) {         // richiama il dialog corretto, controllando se il controllo della traiettoria era abilitato
                            switch (controller.checkSavedData(letterIndex)) {
                              case 0:
                                DialogCustom.failDialog(context, letterIndex);
                                break;
                              case 1:
                                DialogCustom.successDialog(
                                    context, letterIndex);
                                break;
                              case 2:
                                DialogCustom.onlyCompareDialog(
                                    context, letterIndex);
                                break;
                              case 3:
                                DialogCustom.onlyPathDialog(
                                    context, letterIndex);
                                break;
                            }
                          } else {
                            switch (controller.checkSavedData(letterIndex)) {
                              case 1:
                                DialogCustom.successDialog(
                                    context, letterIndex);
                                break;
                              case 3:
                                DialogCustom.failDialog(context, letterIndex);
                                break;
                            }
                          }
                        }
                      },
                    ),
                  );
            },
          );
        },
      ),
      btnCancel: ButtonCustom(
        fontSize: 15.sp,
        buttonText: "Riprova",
        height: 50.h,
        paddingHorizontal: 0,
        buttonColor: AppTheme.colorDanger,
        onPressed: () {
          controller.scribbleNotifier[letterIndex].clear();
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

  /* Dialog di successo completo */
  static void successDialog(BuildContext context, var letterIndex) {
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

  /* Dialog di fallimento completo */
  static void failDialog(BuildContext context, var letterIndex) {
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
          controller.scribbleNotifier[letterIndex].clear();
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

  /* Dialog che informa l'utente che la lettera è già stata completata */
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

  /* Widget che racchiude l'immagine della lettera scritta dall'utente, è stato necessario inserirlo in questo modo 
  poichè altrimenti le dimensioni non erano corrette */
  static drawnImage() {
    DrawPageController controller = Get.find();
    return Container(
        height: 140.h,
        width: 90.w,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 207, 207, 207)),
        child: Image.memory(controller.draw!));
  }

  /* Dialog che informa l'utente che solo l'accuratezza era sufficiente */
  static void onlyCompareDialog(BuildContext context, var letterIndex) {
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
        buttonText: "Riprova",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: Colors.black,
        onPressed: () {
          controller.scribbleNotifier[letterIndex].clear();
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
      title: 'Buono!',
      desc:
          'La lettera è stata scritta con una buona accuratezza, ma non nel modo corretto',
      showCloseIcon: false,
    ).show();
  }

  /* Dialog che informa l'utente che solo la traiettoria di scrittura era corretta */
  static void onlyPathDialog(BuildContext context, var letterIndex) {
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
        buttonText: "Riprova",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: Colors.black,
        onPressed: () {
          controller.scribbleNotifier[letterIndex].clear();
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
      title: 'Buono!',
      desc:
          'La lettera è stata scritta nel modo giusto, ma non era abbastanza precisa',
      showCloseIcon: false,
    ).show();
  }

  /* Dialog di avviso nel momento in cui l'utente richiede l'eliminazione dei progressi */
  static void removeAllDataDialog(BuildContext context) {
    SettingsViewController controller = Get.find();
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
      btnOk: ButtonCustom(
        fontSize: 12.sp,
        buttonText: "Conferma",
        height: 50.h,
        width: 90.w,
        paddingHorizontal: 0,
        buttonColor: AppTheme.colorDanger,
        onPressed: () async {
          controller.deleteAllDatas();
          Get.back();
        },
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
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
      ),
      descTextStyle: TextStyle(
        color: AppTheme.colorTextBlack,
        fontFamily: 'Aeonik',
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
      enableEnterKey: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Rimozione dati',
      desc:
          'Tutti i dati di salvataggio verranno rimossi, sei sicuro di voler proseguire? \n Questa operazione non è reversibile!',
      showCloseIcon: false,
    ).show();
  }
}
