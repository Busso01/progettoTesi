import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progettotesi/src/SelectLetter/selection_view.dart';

class SelectLetter extends StatelessWidget {
  const SelectLetter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.sp),
      child: const SelectionView(),
    );
  }
}
