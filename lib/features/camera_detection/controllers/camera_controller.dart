import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:weedcheck/features/camera_detection/data/labels.dart';
import 'tflite_service.dart';

class CameraControllerX extends ChangeNotifier {
  CameraController? cameraController;
  List<CameraDescription>? cameras;

  bool isRearCamera = true;
  double zoomLevel = 1.0;
  FlashMode flashMode = FlashMode.off;
  double minZoom = 1.0;
  double maxZoom = 5.0;
  double minExposure = 0.0;
  double maxExposure = 0.0;
  double currentExposure = 0.0;

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras == null || cameras!.isEmpty) {
        print("No camera found");
        return;
      }

      await _setupCamera(cameras!.first);

      minZoom = await cameraController!.getMinZoomLevel();
      maxZoom = await cameraController!.getMaxZoomLevel();

      minExposure = await cameraController!.getMinExposureOffset();
      maxExposure = await cameraController!.getMaxExposureOffset();
    } catch (e) {
      print("Camera error: $e");
    }
  }

  Future<void> setExposure(double value) async {
    currentExposure = value;
    await cameraController?.setExposureOffset(value);
    notifyListeners();
  }

  Future<void> _setupCamera(CameraDescription camera) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController!.initialize();
    notifyListeners();
  }

  Future<void> flipCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    isRearCamera = !isRearCamera;

    final newCamera = isRearCamera
        ? cameras!.first
        : cameras!.last;

    /// 🔥 WAJIB dispose dulu
    await cameraController?.dispose();

    /// 🔥 BUAT controller baru
    cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    /// 🔥 INIT ulang
    await cameraController!.initialize();

    notifyListeners();
  }

  Future<void> toggleFlash() async {
    flashMode =
        flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;

    await cameraController?.setFlashMode(flashMode);
    notifyListeners();
  }

  Future<XFile?> takePicture() async {
    if (!cameraController!.value.isInitialized) return null;
    return await cameraController!.takePicture();
  }

  Future<void> setZoom(double value) async {
    zoomLevel = value;
    await cameraController?.setZoomLevel(value);
    notifyListeners();
  }

  void disposeCamera() {
    cameraController?.dispose();
  }

  Future<String> detectImage(String path) async {
    final bytes = await File(path).readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return "Gagal membaca gambar";

    if (_isImageTooDark(image)) {
      return "Gambar terlalu gelap, harap cari tempat yang lebih terang";
    }

    final tflite = TFLiteService();
    await tflite.loadModel();

    final input = tflite.preprocess(image!);
    final output = tflite.runModel(input);

    double bestScore = 0;
    int bestClass = -1;

    // Mendapatkan jumlah baris data (biasanya 7 atau 8 tergantung jumlah class)
    int numRows = output[0].length; 
    int numAnchors = output[0][0].length; // 8400

    for (int i = 0; i < numAnchors; i++) {
      double currentMaxScore = 0;
      int currentClass = -1;

      // Loop mulai dari indeks 4 (skor class pertama) 
      // sampai akhir list (numRows)
      for (int c = 4; c < numRows; c++) { 
        double score = output[0][c][i];
        if (score > currentMaxScore) {
          currentMaxScore = score;
          currentClass = c - 4; 
        }
      }

      if (currentMaxScore > bestScore) {
        bestScore = currentMaxScore;
        bestClass = currentClass;
      }
    }

    print("JUMLAH BARIS OUTPUT: $numRows"); // Cek di console nilainya berapa
    print("BEST SCORE: $bestScore");
    
    if (bestClass == -1 || bestScore < 0.53) {
      return "Tidak terdeteksi gulma";
    }

    // Pastikan indeks bestClass tidak melebihi jumlah label yang Anda buat
    if (bestClass >= Labels.labels.length) {
      return "Terdeteksi (Label Error)";
    }

    return "${Labels.labels[bestClass]} (${(bestScore * 100).toStringAsFixed(1)}%)";
  }

  bool _isImageTooDark(img.Image image) {
    num totalBrightness = 0;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        // image package terbaru menggunakan .r, .g, .b
        totalBrightness += (pixel.r + pixel.g + pixel.b) / 3;
      }
    }
    double avgBrightness = totalBrightness / (image.width * image.height);
    print("Kecerahan rata-rata: $avgBrightness"); // Untuk debug
    return avgBrightness < 30; // Jika di bawah 30, dianggap terlalu gelap
  }
}