import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF8),
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
          'Scegli una lettera',
          style: AppTheme.submainContentTextStyleBlack,
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            width: MediaQuery.of(context).size.width - 30,
            height: MediaQuery.of(context).size.height - 100,
            child: GridView.count(
              crossAxisCount: 3,
              primary: false,
              crossAxisSpacing: 15.w,
              childAspectRatio: 0.8,
              children: List.generate(
                26,
                (index) => letterCard(
                  String.fromCharCode(index + 65),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget letterCard(String letter) {
    return Padding(
        padding:
            EdgeInsets.only(top: 15.h, bottom: 25.h, left: 5.w, right: 5.w),
        child: InkWell(
          onTap: () {
            Get.toNamed('/drawPage');
          },
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
              child: RichText(
                text: TextSpan(
                    text: '$letter${letter.toLowerCase()}\n',
                    style: AppTheme.submainContentTextStyleBlack,
                    children: <TextSpan>[
                      TextSpan(
                        text: letter + letter.toLowerCase(),
                        style:
                            TextStyle(fontFamily: 'Handlee', fontSize: 30.sp),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
