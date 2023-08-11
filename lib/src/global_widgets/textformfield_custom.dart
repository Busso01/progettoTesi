import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/theme.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String label;
  final bool hideText;
  final IconData? prefixIcon;
  final double? marginBottom;
  final double? marginTop;
  final double? marginRight;
  final double? marginLeft;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextFormFieldCustom({
    super.key,
    required this.label,
    required this.hideText,
    this.prefixIcon,
    this.marginBottom,
    this.marginTop,
    this.marginLeft,
    this.marginRight,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0).h,
      margin: EdgeInsets.only(
        bottom: marginBottom ?? 10.w,
        top: marginTop ?? 0.h,
        right: marginRight ?? 0.w,
        left: marginLeft ?? 0.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(const Radius.circular(12).w),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.6),
        //     spreadRadius: 1,
        //     blurRadius: 8,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Center(
        child: TextFormField(
          style: AppTheme.normalContentTextStyle,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          validator: validator,
          inputFormatters: inputFormatters,
          obscureText: hideText,
          cursorColor: AppTheme.colorLilla,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Icon(
                prefixIcon,
                size: 24.sp,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(4).w),
              borderSide: BorderSide(
                color: AppTheme.colorDanger,
                width: 2.0.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(4).w),
              borderSide: BorderSide(
                color: AppTheme.colorLilla,
                width: 2.0.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(4).w),
              borderSide: BorderSide(
                color: AppTheme.colorSuccess,
                width: 2.0.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(4).w),
              borderSide: BorderSide(
                color: AppTheme.colorDanger,
                width: 2.0.w,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(4).w),
              borderSide: BorderSide(
                color: AppTheme.colorSuccess,
                width: 2.0.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
