import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../controllers/camera_controller.dart';

class CameraView extends StatefulWidget {
  final CameraControllerX controller;
  const CameraView({required this.controller});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  double _zoom = 1.0;
  double _baseZoom = 1.0;

  @override
  void dispose() {
    widget.controller.cameraController?.stopImageStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final cam = widget.controller.cameraController;

        // Loading state
        if (cam == null || !cam.value.isInitialized) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    "Memuat kamera...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        return Stack(
          children: [
            // Camera preview
            GestureDetector(
              onScaleStart: (_) => _baseZoom = _zoom,
              onScaleUpdate: (details) async {
                double zoom = (_baseZoom * details.scale).clamp(
                  widget.controller.minZoom,
                  widget.controller.maxZoom,
                );
                _zoom = zoom;
                await widget.controller.setZoom(zoom);
              },
              child: ClipRect(
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: cam.value.previewSize!.height,
                      height: cam.value.previewSize!.width,
                      child: CameraPreview(cam),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
