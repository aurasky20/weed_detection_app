import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
}