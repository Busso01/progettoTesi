import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/theme.dart';

class LetterCard extends StatelessWidget {
  final String letter;
  final VoidCallback openContainer;

  const LetterCard({
    super.key,
    required this.letter,
    required this.openContainer,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      child: Center(
        child: RichText(
          text: TextSpan(
              text: '$letter${letter.toLowerCase()}\n',
              style: AppTheme.submainContentTextStyleBlack,
              children: <TextSpan>[
                TextSpan(
                  text: letter + letter.toLowerCase(),
                  style: TextStyle(fontFamily: 'Handlee', fontSize: 30.sp),
                )
              ]),
        ),
      ),
    );
  }
}
