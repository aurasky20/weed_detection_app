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
  List<Map<String, dynamic>> detections = [];
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      startStream();
    });
  }

  void startStream() async {
    final cam = widget.controller.cameraController;

    if (cam == null || !cam.value.isInitialized) {
      print("Camera belum siap");
      return;
    }

    if (cam.value.isStreamingImages) {
      print("Sudah streaming");
      return;
    }

    await cam.startImageStream((image) async {
      if (isProcessing) return;

      isProcessing = true;

      // 🔥 simulasi deteksi (sementara)
      await Future.delayed(Duration(milliseconds: 100));

      if (!mounted) return;

      setState(() {
        detections = [
          {
            "x": 100.0,
            "y": 200.0,
            "w": 150.0,
            "h": 150.0,
            "class": 1
          }
        ];
      });

      print("Stream started");
      print("Frame masuk");
      isProcessing = false;
    });
  }

  @override
  void dispose() {
    widget.controller.cameraController?.stopImageStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cam = widget.controller.cameraController;

    if (cam == null || !cam.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        /// 📸 CAMERA
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

    /// 🔥 BOUNDING BOX (DI ATAS CAMERA)
    ...detections.map((det) {
      return Positioned(
        left: det["x"],
        top: det["y"],
        width: det["w"],
        height: det["h"],
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _getColor(det["class"]),
              width: 3,
            ),
          ),
        ),
      );
    }).toList(),

        /// 🌞 BRIGHTNESS
        // Positioned(
        //   right: 8,
        //   top: 60,
        //   bottom: 60,
        //   child: Column(
        //     children: [
        //       Icon(Icons.wb_sunny, color: Colors.orange),

        //       Expanded(
        //         child: RotatedBox(
        //           quarterTurns: 3,
        //           child: Slider(
        //             value: widget.controller.currentExposure,
        //             min: widget.controller.minExposure,
        //             max: widget.controller.maxExposure,
        //             onChanged: (value) async {
        //               await widget.controller.setExposure(value);
        //               setState(() {});
        //             },
        //           ),
        //         ),
        //       ),

        //       Icon(Icons.nightlight_round, color: Colors.orange),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

Color _getColor(int classId) {
  switch (classId) {
    case 0:
      return Colors.red;
    case 1:
      return Colors.green;
    case 2:
      return Colors.blue;
    default:
      return Colors.white;
  }
}

