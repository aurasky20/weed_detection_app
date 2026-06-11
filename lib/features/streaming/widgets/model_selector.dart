import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/models/yolo_task.dart';

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
  });

  final YOLOTask selectedTask;
  final String selectedModel;
  final List<YOLOTask> availableTasks;
  final List<String> availableModels;
  final ValueChanged<YOLOTask> onTaskChanged;
  final ValueChanged<String> onModelChanged;

  String _formatModelName(String path) {
    final fileName = path.split('/').last;
    return fileName
        .replaceAll('.tflite', '')
        .replaceAll('_', ' ')
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildModelPicker(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildModelPicker() {
    return Container(
      height: 36,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatModelName(selectedModel),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            elevation: 2,
            enabled: availableModels.isNotEmpty,
            onSelected: onModelChanged,
            itemBuilder: (_) => availableModels
                .map(
                  (model) => PopupMenuItem<String>(
                    value: model,
                    child: Text(_formatModelName(model)),
                  ),
                )
                .toList(),
            child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
