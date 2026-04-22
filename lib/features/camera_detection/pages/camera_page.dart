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
  final controller = CameraControllerX();

  @override
  void initState() {
    super.initState();
    controller.initCamera().then((_) {
      setState(() {});
    });
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
              controller: controller,
              onFlashToggle: () async {
                await controller.toggleFlash();
                setState(() {}); // 🔥 INI KUNCINYA
              },
              onBack: () => Navigator.pop(context),
            ),
          ),

          /// 📸 3/6
          Expanded(
            flex: 5,
            child: CameraView(controller: controller),
          ),

          /// 🎮 2/6
          Expanded(
            flex: 2,
            child: BottomControls(
              controller: controller,
              parentContext: context,
              onFlip: () async {
                await controller.flipCamera();
                setState(() {}); // 🔥 PENTING
              },
            ),
          ),
        ],
      ),
    );
  }
}