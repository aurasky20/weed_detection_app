import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weedcheck/features/tutorial/camera_tutorial.dart';
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

  final GlobalKey infoKey = GlobalKey();
  final GlobalKey flashKey = GlobalKey();
  final GlobalKey galleryKey = GlobalKey();
  final GlobalKey flipKey = GlobalKey();
  final GlobalKey captureKey = GlobalKey();

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
  return ShowCaseWidget(
    builder: (context) => Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          Expanded(
            flex: 1,
            child: TopBar(
              controller: _controller,
              infoKey: infoKey,
              flashKey: flashKey,

              onShowTutorial: () {
                CameraTutorial.start(
                  context,
                  infoKey: infoKey,
                  flashKey: flashKey,
                  galleryKey: galleryKey,
                  flipKey: flipKey,
                  captureKey: captureKey,
                );
              },

              onFlashToggle: () async {
                await _controller.toggleFlash();
                setState(() {});
              },
            ),
          ),

          Expanded(
            flex: 5,
            child: CameraView(
              controller: _controller,
            ),
          ),

          Expanded(
            flex: 2,
            child: BottomControls(
              controller: _controller,
              parentContext: context,
              galleryKey: galleryKey,
              flipKey: flipKey,
              captureKey: captureKey,

              onFlip: () async {
                await _controller.flipCamera();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}