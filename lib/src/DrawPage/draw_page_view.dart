import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/DrawPage/draw_card.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';
import '../../core/theme/theme.dart';

class DrawPageView extends GetView<DrawPageController> {
  const DrawPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'home',
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: buildBody(context),
        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
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
            Get.back();
          },
        ),
      );

  Widget buildBody(BuildContext context) {
    return Obx(
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
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: 4,
              itemBuilder: ((context, index) => DrawCard(index: index)),
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
          ButtonCustom(buttonText: 'SaveForJson', onPressed: (){
            
          },),
          // Obx(() => controller.isDrawSaved.value
          //     ? Image.memory(controller.drawImage!)
          //     : Container()),
          // Obx(() => controller.isWidgetSaved.value
          //     ? Image.memory(controller.widgetImage!)
          //     : Container())
        ],
      ),
    );
  }
}
