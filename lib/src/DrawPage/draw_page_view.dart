import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/DrawPage/draw_section.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';

import '../../core/theme/theme.dart';

class DrawPageView extends StatelessWidget {
  const DrawPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color(0xFF545D68),
            size: 30.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Scrivi la lettera',
          style: AppTheme.submainContentTextStyleBlack,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Ciao',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 46.sp,
                        fontFamily: 'Dancing'),
                  ),
                ),
                const DrawSection(),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 30.h, left: 30.w, right: 30.w, bottom: 40.h),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: GridView.count(
                            crossAxisCount: 4,
                            primary: false,
                            crossAxisSpacing: 20.w,
                            childAspectRatio: 0.8,
                            children: List.generate(
                              4,
                              (index) => selectionTile(
                                String.fromCharCode(index + 65),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.h),
                        child: ButtonCustom(
                          buttonText: 'Conferma',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget selectionTile(String letter) {
    return Padding(
        padding:
            EdgeInsets.only(top: 15.h, bottom: 25.h, left: 5.w, right: 5.w),
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2.r),
                    spreadRadius: 3.0.r,
                    blurRadius: 5.0.r),
              ],
              color: Colors.white,
            ),
            child: Center(
                child: Text(
              letter,
              style: TextStyle(fontFamily: 'Handlee', fontSize: 30.sp),
            )),
          ),
        ));
  }
}
