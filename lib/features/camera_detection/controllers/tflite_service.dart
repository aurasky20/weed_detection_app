import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/models/best_float32.tflite');
  }

  /// PREPROCESS IMAGE
  Float32List preprocess(img.Image image) {
    final resized = img.copyResize(image, width: 640, height: 640);

    Float32List input = Float32List(1 * 640 * 640 * 3);
    int index = 0;

    for (int y = 0; y < 640; y++) {
      for (int x = 0; x < 640; x++) {
        final pixel = resized.getPixel(x, y);

        input[index++] = pixel.r / 255.0;
        input[index++] = pixel.g / 255.0;
        input[index++] = pixel.b / 255.0;
      }
    }
    
    return input;
  }

  /// RUN INFERENCE
  List runModel(Float32List input) {
    var output = List.generate(
      1,
      (i) => List.generate(7, (j) => List.filled(8400, 0.0)),
    );

    _interpreter.run(input.reshape([1, 640, 640, 3]), output);

    return output;
  }
}