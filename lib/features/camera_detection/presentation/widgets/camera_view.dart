import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../controllers/camera_controller.dart';

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
  Widget build(BuildContext context) {
    final cam = widget.controller.cameraController;

    if (cam == null || !cam.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        /// 📸 CAMERA + PINCH ZOOM
        GestureDetector(
          onScaleStart: (details) {
            _baseZoom = _zoom;
          },
          onScaleUpdate: (details) async {
            double zoom = (_baseZoom * details.scale)
                .clamp(widget.controller.minZoom, widget.controller.maxZoom);

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

        /// 🌞 BRIGHTNESS
        Positioned(
          right: 8,
          top: 60,
          bottom: 60,
          child: Column(
            children: [
              Icon(Icons.wb_sunny, color: Colors.orange),

              Expanded(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget.controller.currentExposure,
                    min: widget.controller.minExposure,
                    max: widget.controller.maxExposure,
                    onChanged: (value) async {
                      await widget.controller.setExposure(value);
                      setState(() {});
                    },
                  ),
                ),
              ),

              Icon(Icons.nightlight_round, color: Colors.orange),
            ],
          ),
        ),
      ],
    );
  }
}