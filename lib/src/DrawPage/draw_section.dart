import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pencil_kit/pencil_kit.dart';

import '../../core/theme/theme.dart';

class DrawSection extends StatefulWidget {
  const DrawSection({super.key});

  @override
  State<DrawSection> createState() => _DrawSectionState();
}

class _DrawSectionState extends State<DrawSection> {
  late final PencilKitController controller;
  @override
  Widget build(BuildContext context) {
    return PencilKit(
      onPencilKitViewCreated: (controller) => this.controller = controller,
      alwaysBounceVertical: false,
      alwaysBounceHorizontal: true,
      isRulerActive: false,
      drawingPolicy: PencilKitIos14DrawingPolicy.anyInput,
      onToolPickerVisibilityChanged: (isVisible) {
        if (kDebugMode) {
          print('isToolPickerVisible $isVisible');
        }
      },
      onRulerActiveChanged: (isRulerActive) {
        if (kDebugMode) {
          print('isRulerActive $isRulerActive');
        }
      },
      backgroundColor: Colors.transparent,
      isOpaque: true,
    );
  }
}
