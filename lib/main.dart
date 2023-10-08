import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/DrawPage/draw_page_view.dart';
import 'package:progettotesi/src/SelectLetter/selection_view.dart';
import 'package:progettotesi/src/SelectLetter/selection_view_binding.dart';

import 'src/HomePage/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Migliora la tua Scrittura',
            initialRoute: '/',
            getPages: [
              GetPage(
                name: '/',
                page: () => const HomePage(),
                transition: Transition.noTransition,
              ),
              GetPage(
                name: '/selectionView',
                page: () => const SelectionView(),
                binding: SelectionViewBinding(),
                transition: Transition.noTransition,
              ),
              GetPage(
                name: '/drawPage',
                page: () => const DrawPageView(),
                transition: Transition.noTransition,
              )
            ]);
      },
    );
  }
}
