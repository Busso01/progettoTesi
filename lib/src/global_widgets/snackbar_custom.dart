import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:progettotesi/core/theme/theme.dart';


// Funzione che permette la creazione delle snackbar, passando il titolo ed il messaggi che si vuole mostrare
void snackbarCustomSuccess(String title, String message) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: const TextStyle(
        fontFamily: 'Aeonik',
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        fontFamily: 'Aeonik',
        fontWeight: FontWeight.normal,
        fontSize: 18,
      ),
    ),
    icon: const Icon(
      Icons.beenhere,
      color: AppTheme.colorSuccess,
      size: 40,
    ),
    animationDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 3000),
    backgroundColor: Colors.white,
    borderColor: AppTheme.colorSuccess,
    borderWidth: 1,
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 10,
      ),
    ],
    borderRadius: 20,
    colorText: AppTheme.colorTextBlack,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    padding: const EdgeInsets.all(10),
  );
}

void snackbarCustomDanger(String title, String message) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Aeonik',
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    ),
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Aeonik',
        fontWeight: FontWeight.normal,
        fontSize: 13.sp,
      ),
    ),
    icon: Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Icon(
        Icons.dangerous_rounded,
        color: AppTheme.colorDanger,
        size: 30.sp,
      ),
    ),
    animationDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 3000),
    backgroundColor: Colors.white,
    borderColor: AppTheme.colorDanger,
    borderWidth: 1,
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 10,
      ),
    ],
    borderRadius: 20,
    colorText: AppTheme.colorTextBlack,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    padding: const EdgeInsets.all(10),
  );
}

void snackbarCustomWarning(String title, String message) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: const TextStyle(
        fontFamily: 'Aeonik',
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        fontFamily: 'Aeonik',
        fontWeight: FontWeight.normal,
        fontSize: 18,
      ),
    ),
    icon: const Icon(
      Icons.warning,
      color: AppTheme.colorWarning,
      size: 40,
    ),
    animationDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 3000),
    backgroundColor: Colors.white,
    borderColor: AppTheme.colorWarning,
    borderWidth: 1,
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: const Offset(1, 2),
      ),
    ],
    borderRadius: 20,
    colorText: AppTheme.colorTextBlack,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    padding: const EdgeInsets.all(10),
  );
}
