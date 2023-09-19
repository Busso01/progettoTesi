import 'dart:typed_data';

import 'package:flutter_tflite/flutter_tflite.dart';


class ImageComparisonModel {
  static const modelPath =
      'https://tfhub.dev/google/tf2-preview/mobilenet_v2/classification/4';
   var interpreter;

  Future<void> loadModel() async {
    interpreter = await Tflite.loadModel(
      model: modelPath,
    );
  }

  Future<List<double>> getEmbedding(Uint8List imagePath) async {
    final output = await Tflite.runModelOnBinary(
      binary: imagePath,
    );

    return output![0]['embedding'];
  }
}
