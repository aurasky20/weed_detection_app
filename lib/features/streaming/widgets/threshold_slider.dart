import 'package:flutter/material.dart';
import '../controllers/camera_inference_controller.dart';

/// A slider widget for adjusting threshold values
class ThresholdSlider extends StatelessWidget {
  const ThresholdSlider({
    super.key,
    required this.activeSlider,
    required this.confidenceThreshold,
    required this.iouThreshold,
    required this.numItemsThreshold,
    required this.onValueChanged,
    required this.isLandscape,
  });

  final SliderType activeSlider;
  final double confidenceThreshold;
  final double iouThreshold;
  final int numItemsThreshold;
  final ValueChanged<double> onValueChanged;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    if (activeSlider == SliderType.none) {
      return const SizedBox.shrink();
    }

    final viewPadding = MediaQuery.of(context).viewPadding;
    final horizontalInset = isLandscape ? viewPadding : EdgeInsets.zero;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: (isLandscape ? 16 : 24) + horizontalInset.left,
          right: (isLandscape ? 16 : 24) + horizontalInset.right,
          top: isLandscape ? 8 : 12,
          bottom: (isLandscape ? 8 : 12) + viewPadding.bottom,
        ),
        color: Colors.black.withValues(alpha: 0.8),
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.yellow,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
            thumbColor: Colors.yellow,
            overlayColor: Colors.yellow.withValues(alpha: 0.2),
            valueIndicatorColor: const Color.fromARGB(255, 228, 82, 37),
          ),
          child: Slider(
            value: _getSliderValue(),
            min: _getSliderMin(),
            max: _getSliderMax(),
            divisions: _getSliderDivisions(),
            label: _getSliderLabel(),
            onChanged: onValueChanged,
          ),
        ),
      ),
    );
  }

  double _getSliderValue() {
    if (activeSlider == SliderType.iou) {
      if (iouThreshold <= 0.3) return 0;
      if (iouThreshold <= 0.5) return 1;
      return 2;
    }

    switch (activeSlider) {
      case SliderType.numItems:
        return numItemsThreshold.toDouble();

      case SliderType.confidence:
        return confidenceThreshold;

      default:
        return 0;
    }
  }

  double _getSliderMin() =>
    activeSlider == SliderType.iou ? 0 : 
    activeSlider == SliderType.numItems ? 3 : 0.1;
  double _getSliderMax() =>
    activeSlider == SliderType.iou ? 2 :
    activeSlider == SliderType.numItems ? 30 : 0.9;
  int _getSliderDivisions() =>
    activeSlider == SliderType.iou ? 2 :
    activeSlider == SliderType.numItems ? 9 : 8;
  String _getSliderLabel() {
    if (activeSlider == SliderType.iou) {
      if (iouThreshold <= 0.3) return 'Low';
      if (iouThreshold <= 0.5) return 'Medium';
      return 'High';
    }

    switch (activeSlider) {
      case SliderType.numItems:
        return '$numItemsThreshold';

      case SliderType.confidence:
        return confidenceThreshold.toStringAsFixed(1);

      default:
        return '';
    }
  }
}
