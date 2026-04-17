import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late Interpreter interpreter;

  Future<void> loadModel() async {
    // Pastikan file model ada di assets dan terdaftar di pubspec.yaml
    interpreter = await Interpreter.fromAsset(
      'assets/models/yolov8n_f16.tflite',
    );
  }

  List<double> runModel(List input) {
  // Jika ada 3 jenis gulma + 1 default (total 4), gunakan [1, 4]
  // Sesuaikan dengan jumlah label di switch case Anda
  var output = List<double>.filled(4, 0.0).reshape([1, 4]); 

  interpreter.run(input, output);
  return List<double>.from(output[0]);
}
}