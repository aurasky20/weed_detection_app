import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weedcheck/features/streaming/widgets/topBar_streaming.dart';
import 'package:weedcheck/features/tutorial/streaming_tutorial.dart';
import '../controllers/camera_inference_controller.dart';
import '../widgets/camera_inference_content.dart';
import '../widgets/camera_inference_overlay.dart';
import '../widgets/weed_detection_overlay.dart';
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
  final infoKey = GlobalKey();
  final flashKey = GlobalKey();
  final detectionKey = GlobalKey();
  final fpsKey = GlobalKey();
  final modelKey = GlobalKey();
  final flipKey = GlobalKey();
  final maxItemKey = GlobalKey();
  final confidenceKey = GlobalKey();
  final iouKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      StreamingTutorial.start(
        context,
        infoKey: infoKey,
        flashKey: flashKey,
        detectionKey: detectionKey,
        fpsKey: fpsKey,
        modelKey: modelKey,
        flipKey: flipKey,
        maxItemKey: maxItemKey,
        confidenceKey: confidenceKey,
        iouKey: iouKey,
      );
    });

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

    return ShowCaseWidget(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Column(
                children: [
                  /// 🔝 TOP BAR — style sama dengan CameraPage
                  StreamingTopBar(
                    onBack: () => Navigator.pop(context),
                    onFlashPressed: _controller.toggleFlash,
                    isFlashOn: _controller.isFlashOn,
                    infoKey: infoKey,
                    flashKey: flashKey,
                    onShowTutorial: () {
                      StreamingTutorial.start(
                        context,
                        infoKey: infoKey,
                        flashKey: flashKey,
                        detectionKey: detectionKey,
                        fpsKey: fpsKey,
                        modelKey: modelKey,
                        flipKey: flipKey,
                        maxItemKey: maxItemKey,
                        confidenceKey: confidenceKey,
                        iouKey: iouKey,
                      );
                    },
                  ),
              
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
                            WeedDetectionOverlay(
                              detections: _controller.lastDetections,
                            ),
                            CameraInferenceOverlay(
                              controller: _controller,
                              isLandscape: isLandscape,
                              detectionKey: detectionKey,
                              fpsKey: fpsKey,
                              modelKey: modelKey,
                            ),
                            CameraControls(
                              currentZoomLevel: _controller.currentZoomLevel,
                              isFrontCamera: _controller.isFrontCamera,
                              activeSlider: _controller.activeSlider,
                              onZoomChanged: _controller.setZoomLevel,
                              onSliderToggled: _controller.toggleSlider,
                              onCameraFlipped: _controller.flipCamera,
                              isLandscape: isLandscape,
                              maxItemKey: maxItemKey,
                              // confidenceKey: confidenceKey,
                              // iouKey: iouKey,
                              flipKey: flipKey,
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
                ],
              ),
            ],
          ),
        );
      },
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
