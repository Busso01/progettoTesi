import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/theme.dart';

/* Widget che permette di creare pulsanti personalizzati passando i parametri necessari */
class ButtonCustom extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Color? shadowColor;
  final double? borderRadius;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? elevation;
  final Widget? loadingAnimationWidget;
  final double? marginBottom;
  final double? marginTop;

  const ButtonCustom(
      {super.key,
      required this.buttonText,
      this.onPressed,
      this.buttonColor,
      this.textColor,
      this.shadowColor,
      this.borderRadius,
      this.fontSize,
      this.height,
      this.width,
      this.paddingHorizontal,
      this.paddingVertical,
      this.elevation,
      this.loadingAnimationWidget,
      this.marginBottom,
      this.marginTop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 0, top: marginTop ?? 0),
      width: width ?? 200.w,
      height: height ?? 70.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppTheme.colorPurple,
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal ?? 50.w,
            vertical: paddingVertical ?? 0,
          ),
          textStyle: TextStyle(
            fontFamily: 'Aeonik',
            fontSize: fontSize ?? 16.sp,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: buttonColor ?? AppTheme.colorAnthracite,
          foregroundColor: textColor ?? AppTheme.colorTextWhite,
          elevation: elevation ?? 0,
          shadowColor: shadowColor ?? Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12).r,
          ),
        ),
        child: loadingAnimationWidget ?? Text(buttonText),
      ),
    );
  }
}
