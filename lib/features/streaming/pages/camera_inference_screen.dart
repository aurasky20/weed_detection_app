import 'package:flutter/material.dart';
import '../controllers/camera_inference_controller.dart';
import '../widgets/camera_inference_content.dart';
import '../widgets/camera_inference_overlay.dart';
import '../widgets/camera_controls.dart';
import '../widgets/threshold_slider.dart';

class CameraInferenceScreen extends StatefulWidget {
  const CameraInferenceScreen({super.key});

  @override
  State<CameraInferenceScreen> createState() => _CameraInferenceScreenState();
}

class _CameraInferenceScreenState extends State<CameraInferenceScreen> {
  late final CameraInferenceController _controller;
  int _rebuildKey = 0;

  @override
  void initState() {
    super.initState();
    _controller = CameraInferenceController();
    _controller.initialize().catchError((error) {
      if (mounted) {
        _showError('Model Loading Error', error.toString());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route?.isCurrent == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _rebuildKey++;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          /// 🔝 TOP BAR — style sama dengan CameraPage
          _StreamingTopBar(onBack: () => Navigator.pop(context)),

          /// 📸 CAMERA AREA
          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    CameraInferenceContent(
                      key: ValueKey('camera_content_$_rebuildKey'),
                      controller: _controller,
                      rebuildKey: _rebuildKey,
                    ),
                    CameraInferenceOverlay(
                      controller: _controller,
                      isLandscape: isLandscape,
                    ),
                    CameraControls(
                      currentZoomLevel: _controller.currentZoomLevel,
                      isFrontCamera: _controller.isFrontCamera,
                      activeSlider: _controller.activeSlider,
                      onZoomChanged: _controller.setZoomLevel,
                      onSliderToggled: _controller.toggleSlider,
                      onCameraFlipped: _controller.flipCamera,
                      isLandscape: isLandscape,
                    ),
                    ThresholdSlider(
                      activeSlider: _controller.activeSlider,
                      confidenceThreshold: _controller.confidenceThreshold,
                      iouThreshold: _controller.iouThreshold,
                      numItemsThreshold: _controller.numItemsThreshold,
                      onValueChanged: _controller.updateSliderValue,
                      isLandscape: isLandscape,
                    ),
                  ],
                );
              },
            ),
          ),

          /// 🔀 BOTTOM MODE SWITCHER — style sama dengan CameraPage
          _StreamingBottomBar(),
        ],
      ),
    );
  }

  void _showError(String title, String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

/// Top bar bergaya sama dengan TopBar di CameraPage, tanpa flash dan tanpa back opsional
class _StreamingTopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _StreamingTopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'Streaming',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

    );
  }
}

class _StreamingBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: const SizedBox(height: 20),
      ),
    );
  }
}