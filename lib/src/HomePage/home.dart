import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';

import '../../core/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppTheme.colorWhite),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.colorWhite,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Let's go",
                      textAlign: TextAlign.center,
                      style: AppTheme.mainTitleTextStyleBlack,
                    ),
                    Text(
                      "Writing!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Handlee',
                          fontSize: 46.sp,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 130.h),
                  child: Image.asset(
                    'assets/images/notebook.png',
                  ),
                ),
                ButtonCustom(
                  buttonText: "Gioca!",
                  marginBottom: 40,
                  onPressed: () {
                    Get.toNamed('/selectionView');
                  },
                ),
                ButtonCustom(
                  buttonText: "Impostazioni",
                  marginBottom: 40,
                  onPressed: () {
                    Get.toNamed('/drawPage');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
