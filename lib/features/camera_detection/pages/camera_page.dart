import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = CameraControllerX();
    _controller.initCamera();
  }

  @override
  void dispose() {
    _controller.cameraController?.stopImageStream();
    _controller.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
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
          Expanded(
            flex: 5,
            child: CameraView(controller: _controller),
          ),
          Expanded(
            flex: 2,
            child: BottomControls(
              controller: _controller,
              parentContext: context,
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