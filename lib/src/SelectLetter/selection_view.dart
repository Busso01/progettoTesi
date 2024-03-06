import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_view.dart';
import 'package:progettotesi/src/SelectLetter/selection_view_controller.dart';
import 'letter_card.dart';

/* 
  Classe che rappresenta la pagina di selezione della lettera, la parte centrale riguarda la gridView, ovvero
  il Widget che si occupa di creare la griglia con tutte le lettere, ogni riquadro è un operContainer, nel
  momento in cui viene cliccato viene richiamata la openBuilder, questa eseguirà l'inizializzazione del 
  Controller della DrawPage, dopo di che restituirà la DrawPage stessa che verrà mostrata sullo schermo con
  un'animazione
*/
class SelectionView extends GetView<SelectionViewController> {
  const SelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'home',
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFAF8),
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Colors.black,
          elevation: 5.sp,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            iconSize: 20.sp,
            onPressed: () {
              Get.offNamedUntil('/', ModalRoute.withName('/'));
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
          title: Text(
            'Scegli una lettera',
            style: AppTheme.normalContentTextStyleBoldWhite,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
        ),
        body: GridView.builder(         // Widget di creazione della griglia
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 25.w,
            mainAxisSpacing: 20.h,
          ),
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 35.h, bottom: 30.h),
          itemCount: 26,
          itemBuilder: (context, letterCardIndex) => Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                offset: const Offset(1, 1),
                blurRadius: 5.r,
                spreadRadius: 1,
              ),
            ], borderRadius: BorderRadius.circular(20.r)),
            child: OpenContainer(      // Ogni riquadro quando cliccato aprirà una DrawPage
              closedElevation: 0,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              transitionDuration: const Duration(milliseconds: 400),
              closedBuilder: (context, VoidCallback openContainer) =>
                  LetterCard(
                letter: String.fromCharCode(letterCardIndex + 65),
                openContainer: openContainer,
                letterIndex: letterCardIndex,
              ),
              openBuilder: (context, _) {
                controller.initializeDrawPageController(letterCardIndex);   // richiama l'inizializzazione del controller
                return const DrawPageView();                                // restituisce la DrawPage che verrà mostrata
              },
            ),
          ),
        ),
      ),
    );
  }
}
