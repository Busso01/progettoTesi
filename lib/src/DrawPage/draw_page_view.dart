import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/DrawPage/draw_card.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import '../../core/theme/theme.dart';

class DrawPageView extends GetView<DrawPageController> {
  const DrawPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r))),
        title: Text(
          'Scegli una lettera',
          style: AppTheme.normalContentTextStyleBoldWhite,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            controller.isExpanded.value = false;
            controller.isDrawSaved.value = false;
            controller.isWidgetSaved.value = false;
            Get.back();
          },
        ),
      );

  Widget buildBody() {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Text(
              controller.isExpanded.value
                  ? 'Disegna la lettera,\n conferma quando hai terminato'
                  : 'Clicca sulla tessera \n della lettera che vuoi disegnare',
              textAlign: TextAlign.center,
              style: AppTheme.normalContentTextStyle,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: 4,
              itemBuilder: ((context, index) => DrawCard(index: index)),
              physics: controller.isExpanded.value
                  ? const NeverScrollableScrollPhysics()
                  : null,
            ),
          ),
          Obx(() => controller.isDrawSaved.value
              ? Image.memory(controller.drawImage!)
              : Container()),
          Obx(() => controller.isWidgetSaved.value
              ? Image.memory(controller.widgetImage!)
              : Container())
        ],
      ),
    );
  }
}
