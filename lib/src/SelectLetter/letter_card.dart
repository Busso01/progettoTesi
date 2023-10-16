import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/src/SelectLetter/selection_view_controller.dart';

import '../../core/theme/theme.dart';

class LetterCard extends GetView<SelectionViewController> {
  final String letter;
  final VoidCallback openContainer;
  final List<bool>? isCompleted;
  final int letterIndex;

  const LetterCard({
    super.key,
    required this.letter,
    required this.openContainer,
    required this.isCompleted,
    required this.letterIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: controller.checkSavedDatas(letterIndex) == 2
            ? Border.all(color: AppTheme.colorSuccess, width: 2.w)
            : controller.checkSavedDatas(letterIndex) == 1
                ? Border.all(color: AppTheme.colorWarning, width: 2.w)
                : null,
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: InkWell(
        //onTap: openContainer,
        child: Center(
          child: RichText(
            text: TextSpan(
                text: '$letter${letter.toLowerCase()}\n',
                style: AppTheme.submainContentTextStyleBlack,
                children: <TextSpan>[
                  TextSpan(
                    text: letter + letter.toLowerCase(),
                    style: TextStyle(fontFamily: 'Dancing', fontSize: 30.sp),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
