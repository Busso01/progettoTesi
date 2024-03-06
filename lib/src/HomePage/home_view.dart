import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/src/HomePage/home_view_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';

import '../../core/theme/theme.dart';

/*
  Classe che rappresenta la home page dell'applicazione, contiene semplicemente due pulsanti che portano alla
  pagina di selezione delle lettere oppure alle impostazioni
*/
class HomePage extends GetView<HomeViewController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  fontSize: 40.sp,
                  fontWeight: FontWeight.normal),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 130.h),
              child: Image.asset(
                'assets/images/notebook.png',
              ),
            ),
            Hero(
              tag: 'home',
              child: ButtonCustom(
                buttonText: "Gioca!",
                marginBottom: 40,
                onPressed: () async {
                  List<SavedData?>? savedData = await controller.getAllData();
                  Get.toNamed('/selectionView', arguments: savedData);
                },
              ),
            ),
            Hero(
              tag: 'settings',
              child: ButtonCustom(
                buttonText: "Impostazioni",
                marginBottom: 40.h,
                onPressed: () {
                  Get.toNamed('/settings');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
