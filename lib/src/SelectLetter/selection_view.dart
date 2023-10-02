import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:progettotesi/src/DrawPage/draw_page_view.dart';
import 'letter_card.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF8),
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.black,
        elevation: 5.sp,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 20.sp,
          onPressed: () => Get.offNamedUntil('/', (route) => false),
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 25.w,
          mainAxisSpacing: 20.h,
        ),
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 25.h, bottom: 30.h),
        primary: false,
        itemCount: 26,
        itemBuilder: (context, index) => InkWell(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                offset: const Offset(1, 1),
                blurRadius: 5.r,
                spreadRadius: 1,
              ),
            ], borderRadius: BorderRadius.circular(20.r)),
            child: OpenContainer(
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              transitionDuration: const Duration(milliseconds: 400),
              closedBuilder: (context, VoidCallback openContainer) =>
                  LetterCard(
                letter: String.fromCharCode(index + 65),
                openContainer: openContainer,
              ),
              openBuilder: (context, _) {
                DrawPageController controller = Get.put(DrawPageController());
                controller.selectedLetter = String.fromCharCode(index + 65);
                return const DrawPageView();
              },
            ),
          ),
        ),
      ),
    );
  }
}
