import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/models/yolo_task.dart';
import 'package:weedcheck/features/tutorial/streaming_tutorial.dart';

/// A widget for selecting the active YOLO task and official model.
class ModelSelector extends StatelessWidget {
  const ModelSelector({
    super.key,
    required this.selectedTask,
    required this.selectedModel,
    required this.availableTasks,
    required this.availableModels,
    required this.onTaskChanged,
    required this.onModelChanged,
    required this.modelKey,
  });

  final YOLOTask selectedTask;
  final String selectedModel;
  final List<YOLOTask> availableTasks;
  final List<String> availableModels;
  final ValueChanged<YOLOTask> onTaskChanged;
  final ValueChanged<String> onModelChanged;
  final GlobalKey modelKey;
  String _formatModelName(String path) {
    if (path.contains('n_train6')) {
      return 'Fast Detection (YOLOv8n)';
    }

    if (path.contains('s_train6')) {
      return 'Accurate Detection (YOLOv8s)';
    }

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildModelPicker()],
    );
  }

  Widget _buildModelPicker() {
    return PopupMenuButton<String>(
      color: const Color(0xFF2D2D2D), // warna background dropdown
      onSelected: onModelChanged,
      itemBuilder: (_) => [
        const PopupMenuItem<String>(
          enabled: false,
          height: 20,
          child: SizedBox(
            width: 320,
            child: Text(
              textAlign: TextAlign.center,
              '-- Choose Model --',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const PopupMenuDivider(),
        ...availableModels.map(
          (model) => PopupMenuItem<String>(
            value: model,
            height: 40,
            child: SizedBox(
              width: 320,
              child: Text(
                textAlign: TextAlign.center,
                _formatModelName(model),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
      child: StreamingTutorial.tutorial(
        key: modelKey,
        title: "Model Selector",
        description:
            "Choose the detection mode based on your needs. Use YOLOv8n for faster processing with slightly lower accuracy, or YOLOv8s for higher accuracy with slightly slower processing.",
        child: Container(
          width: 280,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatModelName(selectedModel),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
