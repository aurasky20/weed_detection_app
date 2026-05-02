class DetectionResult {
  final String label;
  final double confidence;
  final double x;
  final double y;
  final double w;
  final double h;

  DetectionResult({
    required this.label,
    required this.confidence,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });
}