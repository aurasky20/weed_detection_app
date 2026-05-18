import 'package:flutter/material.dart';
import 'package:weedcheck/features/streaming/screens/camera_inference_screen.dart';
import '../controllers/camera_controller.dart';
import '../widgets/top_bar.dart';
import '../widgets/camera_view.dart';
import '../widgets/bottom_controls.dart';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraControllerX _controller;
  CameraMode _currentMode = CameraMode.camera;

  @override
  void initState() {
    super.initState();
    _controller = CameraControllerX();
    _controller.initCamera();
  }

  @override
  void dispose() {
    _controller.cameraController?.stopImageStream();
    _controller.disposeCamera().then((_) {
      print("Hardware kamera berhasil dimatikan");
    });
    super.dispose();
  }

  void _onModeChanged(CameraMode mode) { 
    if (mode == _currentMode) return; 
    if (mode == CameraMode.streaming) { 
      // Matikan kamera sebelum pindah ke streaming 
      _controller.cameraController?.stopImageStream(); 
      Navigator.push( 
        context, 
        MaterialPageRoute(
          builder: (_) => const CameraInferenceScreen()), 
      ).then((_) { 
        // Kembali ke mode kamera saat user kembali dari streaming 
        setState(() { 
          _currentMode = CameraMode.camera; 
        }); _controller.initCamera(); 
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          /// 🔝 1/6
          Expanded(
            flex: 1,
            child: TopBar(
              controller: _controller,
              onFlashToggle: () async {
                await _controller.toggleFlash();
                setState(() {});
              },
              onBack: () => Navigator.pop(context),
            ),
          ),

          /// 📸 5/6
          Expanded(
            flex: 5,
            child: CameraView(controller: _controller),
          ),

          /// 🎮 2/6
          Expanded(
            flex: 2,
            child: BottomControls(
              controller: _controller,
              parentContext: context,
              currentMode: _currentMode,
              onModeChanged: _onModeChanged,
              onFlip: () async {
                await _controller.flipCamera();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}