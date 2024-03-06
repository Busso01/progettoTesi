import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/DrawPage/draw_card.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/SelectLetter/selection_view_controller.dart';
import '../../core/theme/theme.dart';

/* 
  La classe DrawPageView rappresenta la pagina contenente le varie card delle lettere, nella quale è possibile
  schegliere lo stile della lettera    
*/
class DrawPageView extends GetView<DrawPageController> {
  const DrawPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.sp,
        toolbarHeight: 60.h,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r))),
        title: Text(
          'Scegli uno stile',
          style: AppTheme.normalContentTextStyleBoldWhite,
        ),
        centerTitle: true,
        leading: IconButton(
          iconSize: 20.sp,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            controller.resetControllerValues();
            SelectionViewController selectionViewController = Get.find();
            selectionViewController.savedData[controller.selectedLetterIndex] =
                controller.savedDataSingleSet;
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, bottom: 10.h),
              child: Text(
                controller.isExpanded.value
                    ? 'Disegna la lettera,\n conferma quando hai terminato'
                    : 'Clicca sulla tessera \n della lettera che vuoi disegnare',
                textAlign: TextAlign.center,
                style: AppTheme.normalContentTextStyle,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              child: PageView.builder(                                         // Widget che si occupa di creare le card delle lettere 
                controller: controller.pageController,
                itemCount: 4,
                itemBuilder: ((context, index) => DrawCard(letterIndex: index)),
                physics: controller.isExpanded.value
                    ? const NeverScrollableScrollPhysics()
                    : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Text(
                controller.isExpanded.value
                    ? 'Clicca sul lato della carta per \ntornare alla selezione'
                    : '',
                textAlign: TextAlign.center,
                style: AppTheme.normalContentTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
