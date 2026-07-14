import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';
import '../controllers/camera_inference_controller.dart';

/// Main content widget that handles the camera view and loading states
class CameraInferenceContent extends StatelessWidget {
  const CameraInferenceContent({
    super.key,
    required this.controller,
    this.rebuildKey = 0,
  });

  final CameraInferenceController controller;
  final int rebuildKey;

  @override
  Widget build(BuildContext context) {
    if (controller.modelPath.isNotEmpty) {
      return Stack(
        children: [
          YOLOView(
            key: ValueKey(
              'yolo_view_${controller.modelPath}_${controller.selectedTask.name}_$rebuildKey',
            ),
            controller: controller.yoloController,
            modelPath: controller.modelPath,
            task: controller.selectedTask,
            streamingConfig: const YOLOStreamingConfig.minimal(),
            onResult: controller.onDetectionResults,
            onPerformanceMetrics: (metrics) =>
                controller.onPerformanceMetrics(metrics.fps),
            lensFacing: controller.lensFacing,
            showOverlays: false,
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: 0.2,
              duration: const Duration(milliseconds: 100),
              child: Container(color: Colors.black),
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Text('Tidak ada model yang dimuat', style: TextStyle(color: Colors.white)),
      );
    }
  }
}
