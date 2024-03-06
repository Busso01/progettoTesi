import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';
import 'package:progettotesi/src/global_widgets/dialog_custom.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';
import 'package:scribble/scribble.dart';

/* La classe DrawCard rappresenta la tessera con la lettera scritta al suo interno, è rappresentata da uno Stack
che permette la sovrapposizione di più Widget  */
class DrawCard extends GetView<DrawPageController> {
  final int letterIndex;

  const DrawCard({
    super.key,
    required this.letterIndex,
  });

  @override
  Widget build(BuildContext context) {
    var height = 400.h; //altezza della card, adattata in base allo schermo
    var width = 195.w; //larghezza della card, adattata in base allo schermo
    int dataSavedValue = controller.checkSavedData(
        letterIndex); //vengono ottenuti i dati salvati relativi alla lettera scelta

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedPositioned(
          //Widget che cambia dimensione nel momento in cui viene cliccato
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
                    await controller.saveDraw(letterIndex).then((drawNotEmpty) {
                      // viene salvata la lettera scritta dall'utente
                      if (drawNotEmpty) {
                        // controllo per assicurarsi che ci sia qualcosa scritto
                        controller.saveLetter(letter()).then(
                            (_) => // viene salvata l'immagine della lettera originale
                                DialogCustom.confirmDrawDialog(
                                    // mostra all'utente il Dialog di conferma
                                    context,
                                    letterIndex));
                      } else {
                        snackbarCustomDanger(
                            'Sezione disegno vuota', //se la la zona di scrittura è vuota, viene mostrata una snackbar
                            'La sezione di disegno non può essere vuota, \n disegna la lettera poi conferma');
                      }
                    });
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
              controller.checkIfAlreadyDone(
                      letterIndex) // controllo per impedire all'utente di modificare una lettera già completata
                  ? DialogCustom.drawAlreadyDoneDialog(context)
                  : controller
                      .openDetailPage(); //se non lo è oppure l'utente vuole procedere, viene espansa la card
            },
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
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
                    controller.selectTitle(letterIndex),
                    style: AppTheme.normalContentTextStyleBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Flexible(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      child: controller.isExpanded.value
                          ? openedDrawCard()
                          : closedDrawCard(dataSavedValue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget della card quando chiusa, mostra i progressi dell'utente
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

  // Widget della card aperta, mostra l'area di disegno
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
            height: 45.h,
          ),
          IconButton(
              iconSize: 20.sp,
              onPressed: () {
                controller.scribbleNotifier[letterIndex].clear();
              },
              icon: SizedBox(
                height: 30.h,
                width: 30.w,
                child: Image.asset('assets/images/rubber.png'),
              )),
        ],
      );

  // Impostazioni dell'area di disegno
  Widget drawSection() {
    controller.setScribbleNotifierSettings(letterIndex);
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
            notifier: controller.scribbleNotifier[letterIndex],
          )),
    );
  }

  // Impostazioni relative alla lettera da ricopiare
  Widget letter() {
    return Container(
      width: 90.w,
      height: 140.h,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 207, 207, 207)),
      child: Center(
        child: letterIndex ==
                0 // in base alla card scelta viene mostrato lo stile corretto
            ? Text(
                controller.selectedLetter,
                style: TextStyle(
                    color: Colors.black, fontSize: 40.sp, fontFamily: 'Aeonik'),
              )
            : letterIndex == 1
                ? Text(
                    controller.selectedLetter.toLowerCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.sp,
                        fontFamily: 'Aeonik'),
                  )
                : letterIndex == 2
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
  }

  /*
    I successivi widget reppresentano la sezione della card che mostra le informazioni dei progressi dell'utente
    per evitare lunghe catene di If sono state separati, ogni wiget rappresenta un possibile risultato.
    Per avere un codice più compatto è possibile aggiungere controlli in modo che venga impostato il giusto stile
    in base al risultato della valutazione
  */

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
        controller.isTrajectoryCheckingOnValue
            ? Container(
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
              )
            : Container(),
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
        controller.isTrajectoryCheckingOnValue
            ? Container(
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
                ))
            : Container(),
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
        controller.isTrajectoryCheckingOnValue
            ? Container(
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
              )
            : Container(),
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
        controller.isTrajectoryCheckingOnValue
            ? Container(
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
              )
            : Container(),
      ],
    );
  }
}
