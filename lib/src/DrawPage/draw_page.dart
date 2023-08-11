import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pencil_kit/pencil_kit.dart';

void main() {
  runApp(const DrawPage());
}

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<DrawPage> createState() => _MyAppState();
}

class _MyAppState extends State<DrawPage> {
  late final PencilKitController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PencilKit Example'),
          actions: [
            IconButton(
              icon: const Icon(Icons.palette),
              onPressed: () => controller.show(),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => controller.hide(),
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () => controller.undo(),
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              onPressed: () => controller.redo(),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.clear(),
            ),
          ],
        ),
        body: PencilKit(
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
          backgroundColor: Colors.blue.withOpacity(0.1),
          isOpaque: false,
        ),
      ),
    );
  }
}
