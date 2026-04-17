import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late Interpreter interpreter;

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset(
      'models/yolov8s_f16.tflite',
    );
  }

  List<dynamic> runModel(List input) {
    var output = List.filled(1 * 25200 * 85, 0).reshape([1, 25200, 85]);

    interpreter.run(input, output);

    return output;
  }
}