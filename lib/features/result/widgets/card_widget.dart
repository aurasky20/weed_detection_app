import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final String result;
  final bool detected;

  const ResultCard({
    super.key,
    required this.result,
    required this.detected,
  });

  bool get isInvalidImage =>
      result.toLowerCase().contains("gelap") ||
      result.toLowerCase().contains("black");

  @override
  Widget build(BuildContext context) {
    /// 🔥 STATUS LOGIC
    late Color color;
    late IconData icon;
    late String statusText;

    if (isInvalidImage) {
      color = Colors.grey;
      icon = Icons.visibility_off;
      statusText = "Weeds not found / Image too dark";
    } else if (detected) {
      color = const Color(0xFF41B06E);
      icon = Icons.check_circle;
      statusText = "Weeds detected successfully";
    } else {
      color = const Color(0xFFEF9651);
      icon = Icons.error_outline;
      statusText = "Weeds not detected";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 🔥 STATUS ICON
          Icon(icon, color: color, size: 40),

          const SizedBox(height: 10),

          /// 🔥 STATUS TEXT
          Text(
            statusText,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          /// Label
          Text(
            "Detection Result",
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF18230F).withOpacity(0.45),
            ),
          ),

          const SizedBox(height: 6),

          /// RESULT TEXT
          Text(
            result.isNotEmpty ? result : "Weed not identified",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18230F),
              letterSpacing: -0.3,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}