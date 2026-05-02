import 'package:tflite_flutter/tflite_flutter.dart';
import 'detection_result.dart';

class DetectionService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('model.tflite');
  }

  List<DetectionResult> runModel(List input) {
    // TODO: parsing output YOLO kamu di sini
    List<DetectionResult> results = [];

    // contoh dummy
    results.add(
      DetectionResult(
        label: "Daun Lebar",
        confidence: 0.87,
        x: 0.2,
        y: 0.3,
        w: 0.4,
        h: 0.5,
      ),
    );

    return results;
  }
}