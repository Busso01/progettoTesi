import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  //COLORI
  static const colorTextWhite = Color.fromARGB(255, 255, 255, 255);
  static const colorTextBlack = Color.fromARGB(255, 22, 22, 22);
  static const colorText3 = Color.fromARGB(255, 89, 67, 188);

  static const colorBlue = Color.fromARGB(255, 23, 70, 162);
  static const colorSecondary = Color.fromARGB(255, 95, 157, 247);

  static const colorSenary = Color.fromARGB(255, 51, 137, 250);
  static const colorSeptenary = Color.fromARGB(255, 17, 88, 255);

  static const colorSuccess = Color.fromARGB(255, 35, 215, 80);
  static const colorDanger = Color.fromARGB(255, 202, 24, 24);
  static const colorWarning = Color.fromARGB(255, 222, 218, 13);
  static const colorAnthracite = Color.fromARGB(255, 22, 22, 22);
  static const colorOrange = Color.fromARGB(255, 247, 147, 84);
  static const colorLilla = Color.fromARGB(255, 92, 117, 231);
  static const colorPurple = Color.fromARGB(255, 89, 67, 188);
  static const colorPurpleDark = Color.fromARGB(255, 43, 22, 139);

  static const colorWhite = Color.fromARGB(255, 255, 255, 255);

  static const int _bluePrimaryValue = 0xFF2196F3;

  //STILE TESTI
  static final pagesTitleTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
  );

  static final pagesSubitleTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 20.sp,
    fontWeight: FontWeight.w300,
  );

  static final mainTitleTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 46.sp,
    fontWeight: FontWeight.w700,
  );

  static final mainTitleTextStylePurple = TextStyle(
    color: colorPurpleDark,
    fontFamily: 'Aeonik',
    fontSize: 46.sp,
    fontWeight: FontWeight.w700,
  );

  static final submainTitleTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 30.sp,
    fontWeight: FontWeight.w300,
  );

  static final submainTitleTextStylePurple = TextStyle(
    color: colorPurpleDark,
    fontFamily: 'Aeonik',
    fontSize: 30.sp,
    fontWeight: FontWeight.w300,
  );

  static final mainTitleTextStyleBlack = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 46.sp,
    fontWeight: FontWeight.w700,
  );

  static final submainTitleTextStyleBlack = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 30.sp,
    fontWeight: FontWeight.w300,
  );

  static final mainContentTextStyleBlack = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 33.sp,
    fontWeight: FontWeight.w700,
  );

  static final mainContentTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 33.sp,
    fontWeight: FontWeight.w700,
  );

  static final mainContentTextStylePurple = TextStyle(
    color: colorPurpleDark,
    fontFamily: 'Aeonik',
    fontSize: 33.sp,
    fontWeight: FontWeight.w700,
  );

  static final submainContentTextStyleBlack = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 25.sp,
    fontWeight: FontWeight.w400,
  );

  static final submainContentTextStylePurple = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 25.sp,
    fontWeight: FontWeight.w400,
  );

  static final submainContentTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 25.sp,
    fontWeight: FontWeight.w400,
  );

  static final normalContentTextStyle = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static final normalContentTextStyleWhite = TextStyle(
    color: colorTextWhite,
    fontFamily: 'Aeonik',
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static final normalContentTextStyleBold = TextStyle(
    color: colorTextBlack,
    fontFamily: 'Aeonik',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  //TIMELINE COLORI
  static const colorFirstHour = Color.fromARGB(255, 255, 240, 215);
  static const colorSecondHour = Color.fromARGB(255, 255, 224, 245);
  static const colorThirdHour = Color.fromARGB(255, 217, 231, 253);
  static const colorFourthHour = Color.fromARGB(255, 230, 248, 202);

  //THEMEDATA
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    fontFamily: 'Aeonik',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: colorTextWhite,
        fontSize: 46,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: colorTextWhite,
        fontSize: 30,
        fontWeight: FontWeight.w300,
      ),
      displaySmall: TextStyle(
        color: colorTextWhite,
        fontSize: 26,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: colorTextBlack,
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
      bodyLarge: TextStyle(
        color: colorTextBlack,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: colorTextBlack,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        color: colorTextBlack,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      titleSmall: TextStyle(
        color: colorTextBlack,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
    ), colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(
      _bluePrimaryValue,
      <int, Color>{
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(_bluePrimaryValue),
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF0D47A1),
      },
    )).copyWith(background: colorWhite),
  );
}
